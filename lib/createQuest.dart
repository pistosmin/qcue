// dart packages
import 'dart:async';
import 'dart:io';

// flutter packages
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// firebase packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'questList.dart';
import 'quest.dart';
import 'DateTimeItem.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
        style: theme.textTheme.subhead,
        child: Row(children: <Widget>[
          Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: theme.dividerColor))),
                  child: InkWell(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate:
                                    date.subtract(const Duration(days: 30)),
                                lastDate: date.add(const Duration(days: 30)))
                            .then<void>((DateTime value) {
                          if (value != null)
                            onChanged(DateTime(value.year, value.month,
                                value.day, time.hour, time.minute));
                        });
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(DateFormat('EEE, MMM d yyyy').format(date)),
                            const Icon(Icons.arrow_drop_down,
                                color: Colors.black54),
                          ])))),
          Container(
              margin: const EdgeInsets.only(left: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: theme.dividerColor))),
              child: InkWell(
                  onTap: () {
                    showTimePicker(context: context, initialTime: time)
                        .then<void>((TimeOfDay value) {
                      if (value != null)
                        onChanged(DateTime(date.year, date.month, date.day,
                            value.hour, value.minute));
                    });
                  },
                  child: Row(children: <Widget>[
                    Text('${time.format(context)}'),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ])))
        ]));
  }
}

class CreateQuestPage extends StatefulWidget {
  @override
  CreateQuestPageState createState() => new CreateQuestPageState();
}

class CreateQuestPageState extends State<CreateQuestPage> {
  DateTime _fromDateTime = DateTime.now();
  DateTime _toDateTime = DateTime.now();

  bool _allDayValue = false;
  bool _saveNeeded = false;
  bool _hasLocation = false;
  bool _hasName = false;
  String _eventName;

  bool _hasPeriod = false;

  String dropdownValue1;
  String dropdownValue2;

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasLocation || _hasName || _saveNeeded;
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('퀘스트 작성을 취소할까요?', style: dialogTextStyle),
              actions: <Widget>[
                FlatButton(
                    child: const Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop(
                          false); // Pops the confirmation dialog but not the page.
                    }),
                FlatButton(
                    child: const Text('삭제'),
                    onPressed: () {
                      Navigator.of(context).pop(
                          true); // Returning true to _onWillPop will pop again.
                    })
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_hasName ? _eventName : '퀘스트 만들기'),
        actions: <Widget> [
          FlatButton(
            child: Text('저장', style: theme.textTheme.body1.copyWith(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context, DismissDialogAction.save);
            }
          )
        ]      ),
      body: Form(
        onWillPop: _onWillPop,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '퀘스트 이름',
                  filled: true
                ),
                // style: theme.textTheme.headline,
                onChanged: (String value) {
                  setState(() {
                    _hasName = value.isNotEmpty;
                    if (_hasName) {
                      _eventName = value;
                      _saveNeeded = true;
                    }
                  });
                }
              )
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '장소',
                  hintText: '어디서 하나요?',
                  filled: true
                ),
                onChanged: (String value) {
                  setState(() {
                    _hasLocation = value.isNotEmpty;
                  });
                }
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('기간이 있나요?',),
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: theme.dividerColor)) //theme.dividerColor
                  ),
                  child: Row(
                    children: <Widget> [
                      Checkbox(
                        value: _hasPeriod,
                        onChanged: (bool value) {
                          setState(() {
                            _hasPeriod = value;
                            _saveNeeded = true;
                          });
                        }
                      ),
                      const Text('일정'),
                    ]
                  )
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('시작',),
                DateTimeItem(
                  dateTime: _fromDateTime,
                  onChanged: (DateTime value) {
                    setState(() {
                      _fromDateTime = value;
                      _saveNeeded = true;
                    });
                  }
                )
              ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('끝',),
                DateTimeItem(
                  dateTime: _toDateTime,
                  onChanged: (DateTime value) {
                    setState(() {
                      _toDateTime = value;
                      _saveNeeded = true;
                    });
                  }
                ),
                const Text('All-day'),
              ]
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black)) //theme.dividerColor
              ),
              child: Row(
                children: <Widget> [
                  Checkbox(
                    value: _allDayValue,
                    onChanged: (bool value) {
                      setState(() {
                        _allDayValue = value;
                        _saveNeeded = true;
                      });
                    }
                  ),
                  const Text('All-day'),
                ]
              )
            )
          ]
          .map<Widget>((Widget child) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              height: 96.0,
              child: child
            );
          })
          .toList()
        )
      ),
    );
  }
}
