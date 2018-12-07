import 'package:flutter/material.dart';

typedef OnChangedCallback = Function(String item);

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/profile");
      },
      child: new Container(
          alignment: Alignment.topRight,
          height: 35.0,
          width: 35.0,
          padding: new EdgeInsets.only(left: 10.0, top: 5.0),
          margin: new EdgeInsets.only(top: 10.0),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                image: new AssetImage(
                  'assets/avatar.jpg',
                ),
                fit: BoxFit.cover),
          ),
          child: new Icon(
            Icons.fiber_manual_record,
            color: Colors.red,
            size: 10.0,
          )),
    );
  }
}
