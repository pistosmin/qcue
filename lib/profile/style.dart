import 'package:flutter/material.dart';

TextStyle subHeader =
    new TextStyle(color: Colors.black, fontSize: 12.0, fontFamily: 'NanumSquare');
TextStyle subTitle =
    new TextStyle(color: Colors.white, fontSize: 12.0, fontFamily: 'NanumSquare');
TextStyle header = new TextStyle(
  color: const Color.fromRGBO(0, 0, 0, 1.0),
  fontSize: 18.0,
);
TextStyle title = new TextStyle(
  color: const Color.fromRGBO(0, 0, 0, 0.5),
  fontSize: 16.0,
);
TextStyle timeStyle = new TextStyle(
  color: const Color.fromRGBO(0, 0, 0, 1.0),
  fontSize: 20.0,
);
TextStyle appTitle =
    new TextStyle(fontSize: 30.0, fontFamily: 'NanumSquare', color: Colors.white);
BoxDecoration decoration = new BoxDecoration(
  image: new DecorationImage(
    image: new AssetImage('assets/profile_bg.jpg'),
    fit: BoxFit.cover,
  ),
);
BoxDecoration border = new BoxDecoration(
    border: new Border(
        bottom: new BorderSide(
            color: const Color.fromRGBO(0, 0, 0, 0.2), width: 1.0)));

decoratepic(pic) {
  return new BoxDecoration(
    borderRadius: new BorderRadius.all(const Radius.circular(50.0)),
    color: Colors.black,
    image: new DecorationImage(
      image: new AssetImage(pic),
      fit: BoxFit.cover,
    ),
  );
}

BoxDecoration pic = new BoxDecoration(
  shape: BoxShape.circle,
  image: new DecorationImage(
    image: new AssetImage(
      'assets/avatar.jpg',
    ),
  ),
);
