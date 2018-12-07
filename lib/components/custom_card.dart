import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final List<dynamic> list;
  final dynamic textColor;
  CustomCard({this.list, this.textColor});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, int i) {
        return new Container(
          padding: const EdgeInsets.only(left: 22.0, bottom: 10.0),
          child: new Row(
            children: <Widget>[
              new Container(
                width: 40.0,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.only(
                        bottom: 6.0,
                      ),
                      padding: const EdgeInsets.only(left: 0.0),
                      child: new Text(
                        list[i].hour,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            color: textColor,
                            fontSize: 25.0,
                            fontFamily: 'NanumSquare'),
                      ),
                    ),
                    new Text(
                      list[i].meridian,
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                          color: textColor,
                          fontSize: 12.0,
                          fontFamily: 'NanumSquare'),
                    )
                  ],
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(left: 12.0),
                  child: new Icon(
                Icons.fiber_manual_record,
                color: list[i].labelColor,
                size: 15.0,
              )),
              new Container(
                width: screenSize.width - 150.0,
                // padding: const EdgeInsets.only(left: 60.0),
                padding:
                    const EdgeInsets.only(left: 40.0, bottom: 20.0, top: 20.0),
                decoration: new BoxDecoration(
                  color: const Color.fromRGBO(255, 51, 102, 0.0),
                  border: new Border(
                    bottom: new BorderSide(color: Colors.white, width: 0.5),
                  ),
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.only(bottom: 6.0),
                      child: new Text(
                        list[i].task,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                            color: textColor,
                            fontSize: 18.0,
                            fontFamily: 'NanumSquare'),
                      ),
                    ),
                    new Text(
                      list[i].source,
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                          color: textColor,
                          fontSize: 12.0,
                          fontFamily: 'NanumSquare'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
