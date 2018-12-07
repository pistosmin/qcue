import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  final Function save;
  const AddItem({Key key, this.save}) : super(key: key);

  @override
  AddItemState createState() => new AddItemState(save: save);
}

class AddItemState extends State<AddItem> {
  dynamic color = const Color.fromRGBO(0, 0, 0, 0.5);
  dynamic icon = Icons.panorama_fish_eye;
  final Function save;

  AddItemState({this.save});

  icnPressed() {
    setState(() {
      if (icon == Icons.panorama_fish_eye) {
        icon = Icons.done;
        color = Colors.green;
      } else {
        icon = Icons.panorama_fish_eye;
        color = const Color.fromRGBO(0, 0, 0, 0.5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Center(
      child: new Card(
        elevation: 100.0,
        color: Colors.white,
        child: new Container(
          height: screenSize.height / 2.5,
          width: screenSize.width - 100.0,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                child: new Text(
                  'Add Item',
                  style: new TextStyle(
                      fontSize: 25.0,
                      color: new Color.fromRGBO(107, 85, 153, 1.0)),
                ),
              ),
              new Container(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(
                          icon,
                          color: color,
                          size: 20.0,
                        ),
                        onPressed: this.icnPressed),
                    new Expanded(
                      child: new Container(
                        margin: new EdgeInsets.only(bottom: 20.0, right: 10.0),
                        decoration: new BoxDecoration(
                          border: new Border(
                            bottom: new BorderSide(
                                color: const Color.fromRGBO(0, 0, 0, 0.2),
                                width: 1.0),
                          ),
                        ),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Add Item...',
                            labelText: 'Password',
                            border: InputBorder.none,
                            labelStyle: new TextStyle(
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
              ),
              new RaisedButton(
                onPressed: this.save,
                child: new Text(
                  'ADD',
                  style: new TextStyle(color: Colors.white),
                ),
                color: new Color.fromRGBO(107, 85, 153, 1.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
