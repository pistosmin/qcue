import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final bool allowBorder;
  SettingCard({this.title, this.allowBorder});
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(top: 18.0, bottom: 18.0),
      decoration: new BoxDecoration(
        border: (allowBorder != false
            ? new Border(
                bottom: new BorderSide(
                    color: new Color.fromRGBO(0, 0, 0, 0.2), width: 1.0),
              )
            : null),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            title,
            style: new TextStyle(fontSize: 16.0, fontFamily: 'NanumSquare'),
          ),
          Theme.of(context).platform == TargetPlatform.iOS
              ? new CupertinoSwitch(
                  value: true,
                  onChanged: (value) => !value,
                  activeColor: new Color.fromRGBO(107, 85, 153, 1.0),
                )
              : new Switch(
                  value: true,
                  onChanged: (value) => value = !value,
                  activeColor: new Color.fromRGBO(107, 85, 153, 1.0),
                ),
        ],
      ),
    );
  }
}
