import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final dynamic controller;
  final dynamic icon;
  final String hint;
  final bool protected;
  final dynamic validate;
  final bool enable;
  final TextInputType type;
  InputField(
      {this.icon,
      this.controller,
      this.hint,
      this.protected,
      this.validate,
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
            size: 30.0,
            color: Colors.white,
          ),
          new Expanded(
            child: new Container(
              margin: const EdgeInsets.only(left: 15.0),
              padding: const EdgeInsets.only(right: 15.0),
              decoration: new BoxDecoration(
                //borderRadius: new BorderRadius.all(const Radius.circular(8.0)),
                border: new Border(
                    bottom: new BorderSide(color: Colors.white, width: 1.5)),
              ),
              child: new TextFormField(
                obscureText: protected,
                keyboardType: type == TextInputType.emailAddress
                    ? type
                    : TextInputType.text,
                enabled: enable == false ? enable : true,
                controller: controller,
                validator: validate,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
                decoration: new InputDecoration(
                  hintText: hint,
                  enabled: true,
                  border: InputBorder.none,
                  hintStyle: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.0),
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
