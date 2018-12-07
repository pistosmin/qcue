import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final dynamic icon;
  final String hint;
  final bool protected;
  final dynamic color;
  final bool enable;
  final TextInputType type;
  InputField(
      {this.icon,
      this.controller,
      this.hint,
      this.protected,
      this.color,
      this.enable,
      this.type});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: new Row(
        children: <Widget>[
          new Icon(
            icon,
            size: 20.0,
            color: const Color.fromRGBO(0, 0, 0, 0.5),
          ),
          new Expanded(
            child: new Container(
              margin: const EdgeInsets.only(left: 15.0),
              padding: const EdgeInsets.only(right: 15.0),
              decoration: new BoxDecoration(
                border: new Border(
                    bottom: new BorderSide(
                        color: const Color.fromRGBO(0, 0, 0, 0.2), width: 1.5)),
              ),
              child: new TextFormField(
                obscureText: protected,
                keyboardType: type == TextInputType.emailAddress
                    ? type
                    : TextInputType.text,
                enabled: enable == false ? enable : true,
                controller: controller,
                style: new TextStyle(
                  color: color,
                  fontSize: 15.0,
                ),
                decoration: new InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  hintStyle: new TextStyle(
                      color: color,
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0),
                  fillColor: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
