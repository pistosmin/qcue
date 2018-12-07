import 'package:flutter/material.dart';

typedef OnChangedCallback = Function(String item);

class CustomHeader extends StatelessWidget {
  final dynamic iconTL;
  final dynamic iconTR;
  final String title;
  final String subTitle;
  final String header;
  final String bg;

  CustomHeader({
    this.iconTL,
    this.iconTR,
    this.title,
    this.subTitle,
    this.header,
    this.bg,
  });
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Stack(
      children: <Widget>[
        new Container(),
        new Column(
          children: <Widget>[
            new Container(
              height: screenSize.height / 3.5,
              padding: new EdgeInsets.only(top: 25.0),
              width: screenSize.width,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(bg),
                  fit: BoxFit.cover,
                ),
              ),
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      iconTL,
                      iconTR,
                    ],
                  ),
                  new Container(
                    padding: const EdgeInsets.only(left: 25.0, top: 15.0),
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Text(
                              title,
                              style: new TextStyle(
                                  fontSize: 35.0,
                                  fontFamily: 'NanumSquare',
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(
                              subTitle,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'NanumSquare',
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
