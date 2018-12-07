import 'package:flutter/material.dart';

BoxDecoration border = new BoxDecoration(
  border: new Border(
    bottom:
        new BorderSide(width: 1.0, color: const Color.fromRGBO(0, 0, 0, 0.2)),
  ),
);
InputDecoration inputDecoration = new InputDecoration(
  border: InputBorder.none,
  labelStyle: new TextStyle(fontSize: 15.0),
);
TextStyle titleStyle =
    new TextStyle(color: const Color.fromRGBO(0, 0, 0, 0.5), fontSize: 18.0);
TextStyle subTitle =
    new TextStyle(color: const Color.fromRGBO(0, 0, 0, 0.8), fontSize: 15.0);
decoratePic(pic) {
  return new BoxDecoration(
    borderRadius: new BorderRadius.all(const Radius.circular(50.0)),
    color: Colors.black,
    image: new DecorationImage(
      image: new AssetImage(pic),
      fit: BoxFit.cover,
    ),
  );
}
