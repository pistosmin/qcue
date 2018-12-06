import 'package:flutter/material.dart';
import 'package:project_qcue/components/drawer.dart';
import 'package:project_qcue/components/custom_header.dart';
import 'package:project_qcue/components/profile.dart';
import 'package:project_qcue/components/buttons.dart';
import 'package:project_qcue/components/date_time_picker.dart';
import 'package:project_qcue/components/add-edit/add_edit_card.dart';
import 'package:project_qcue/model/data.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'style.dart';

class AddEdit extends StatefulWidget {
  final String id;
  const AddEdit({Key key, this.id}) : super(key: key);
  @override
  AddEditState createState() => new AddEditState(id: this.id);
}

class AddEditState extends State<AddEdit> {
  FocusNode focus1 = new FocusNode();
  FocusNode focus2 = new FocusNode();
  FocusNode focus3 = new FocusNode();
  FocusNode focus4 = new FocusNode();
  String id;
  String title;
  String selectedDate =
      new DateFormat.yMMMd().format(new DateTime.now()).toString();
  TimeOfDay selectedTime1 = const TimeOfDay(hour: 9, minute: 00);
  TimeOfDay selectedTime2 = const TimeOfDay(hour: 10, minute: 00);
  bool edit = false;
  dynamic icon = Icons.edit;
  dynamic color = new Color.fromRGBO(0, 0, 0, 0.3);
  HomeCardData list;
  AddEditState({this.id});
  onPressed() {
    setState(() {
      if (id == '') {
        closeKeyboard();
        new Timer(Duration(milliseconds: 100), () {
          Navigator.pop(context);
        });
      } else {
        if (edit) {
          icon = Icons.edit;
          edit = false;
          color = new Color.fromRGBO(0, 0, 0, 0.3);
        } else {
          icon = Icons.done;
          edit = true;
          color = new Color.fromRGBO(107, 85, 153, 1.0);
        }
      }
    });
  }

  closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  openCalender() async {
    if (edit || id == '') {
      selectDate(context).then((date) {
        setState(() {
          if (date != null) selectedDate = date;
        });
      });
    }
  }

  openTimePicker() async {
    if (edit || id == '') {
      await selectTime(context, selectedTime1).then((time) => setState(() {
            if (time != null) selectedTime1 = time;
          }));
      await selectTime(context, selectedTime2).then((time) => setState(() {
            if (time != null) selectedTime2 = time;
          }));
    }
  }

  @override
  initState() {
    super.initState();
    if (id == '') {
      list = new DataListBuilder().newList[0];
      icon = Icons.done;
      color = new Color.fromRGBO(107, 85, 153, 1.0);
      title = 'New Task';
      edit = true;
    } else {
      list = new DataListBuilder().cardList[int.parse(id)];
      title = list.task;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Stack(
      children: <Widget>[
        new Scaffold(
          primary: true,
          drawer: new CustomDrawer(),
          body: new Column(
            children: <Widget>[
              new CustomHeader(
                iconTL: new IconButton(
                  icon: new Icon(
                    Icons.clear,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    closeKeyboard();
                    new Timer(Duration(milliseconds: 100), () {
                      Navigator.pop(context);
                    });
                  },
                ),
                iconTR: new Container(
                    padding: new EdgeInsets.only(right: 15.0),
                    child: new ProfilePic()),
                title: title,
                subTitle: '',
                bg: 'assets/task_bg.jpg',
              ),
              new Expanded(
                child: new ListView(
                  children: <Widget>[
                    new Column(
                      //  padding: new EdgeInsets.only(top: 5.0),
                      children: <Widget>[
                        new AddEditCard(
                          focus: focus1,
                          enable: edit,
                          initialValue: list.task,
                          title: 'Title',
                        ),
                        new Container(
                          decoration: border,
                          padding: new EdgeInsets.only(left: 15.0, right: 15.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text('Date', style: titleStyle),
                              new Padding(
                                padding:
                                    new EdgeInsets.only(top: 5.0, bottom: 5.0),
                                child: new Row(
                                  children: <Widget>[
                                    new Text(selectedDate, style: subTitle),
                                    new IconButton(
                                      icon: new Icon(
                                        Icons.date_range,
                                        color: color,
                                        size: 25.0,
                                      ),
                                      onPressed: () {
                                        closeKeyboard();
                                        new Timer(Duration(milliseconds: 100),
                                            () {
                                          openCalender();
                                        });
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          decoration: border,
                          padding: new EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: new Text('From', style: titleStyle),
                                  ),
                                  new Text(selectedTime1.format(context),
                                      style: subTitle),
                                ],
                              ),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: new Text('To', style: titleStyle),
                                  ),
                                  new Text(selectedTime2.format(context),
                                      style: subTitle),
                                ],
                              ),
                              new IconButton(
                                icon: new Icon(
                                  Icons.access_time,
                                  color: color,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  closeKeyboard();
                                  new Timer(Duration(milliseconds: 100), () {
                                    openTimePicker();
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        new AddEditCard(
                          focus: focus2,
                          enable: edit,
                          initialValue: list.source,
                          title: "Location",
                        ),
                        new AddEditCard(
                          focus: focus3,
                          enable: edit,
                          initialValue: "20 min before",
                          title: "Notification",
                        ),
                        list.pic.length > 0
                            ? new PicCard(
                                enable: edit,
                                title: "Who's going",
                                list: list.pic,
                              )
                            : new Container(),
                        new AddEditCard(
                          focus: focus4,
                          enable: edit,
                          initialValue: "none",
                          title: "Repeat",
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(
            right: 15.0,
          ),
          child: new TopFloatButton(
            icon: icon,
            top: screenSize.height / 4.2,
            navigate: () => onPressed(),
          ),
        ),
      ],
    );
  }
}
