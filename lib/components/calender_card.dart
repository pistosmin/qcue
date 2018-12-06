import 'package:flutter/material.dart';

class CalenderCard extends StatelessWidget {
  final List<dynamic> list;
  final String type;
  CalenderCard({this.list, this.type});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    int count = 0;
    return new Container(
      child: new ListView(
        padding: const EdgeInsets.only(top: 0.0),
        children: <Widget>[
          new Column(
              children: list.map((data) {
            count++;
            return new Row(children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(left: 25.0, top: 0.0),
                decoration: new BoxDecoration(
                  border: (count != list.length
                      ? new Border(
                          bottom: new BorderSide(
                              color: new Color.fromRGBO(0, 0, 0, 0.2),
                              width: 1.0),
                        )
                      : null),
                ),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      width: 50.0,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(
                              bottom: 6.0,
                            ),
                            padding: const EdgeInsets.only(left: 0.0),
                            child: new Text(
                              type == 'date' ? data.hour : data.day,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontFamily: 'NanumSquare'),
                            ),
                          ),
                          type == 'date'
                              ? new Text(
                                  data.meridian,
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontFamily: 'NanumSquare'),
                                )
                              : new Container()
                        ],
                      ),
                    ),
                    new Container(
                      width: screenSize.width - 95,
                      height: 70.0,
                      margin: const EdgeInsets.only(left: 20.0),
                      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                      decoration: new BoxDecoration(
                        color: data.statusColor,
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(bottom: 6.0),
                            child: new Text(
                              data.task,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'NanumSquare'),
                            ),
                          ),
                          new Text(
                            data.source,
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontFamily: 'NanumSquare'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]);
          }).toList()),
        ],
      ),
    );
  }
}
