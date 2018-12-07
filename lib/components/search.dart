import 'package:flutter/material.dart';

typedef OnChangedCallback = Function(String item);

class Search extends StatelessWidget {
  final OnChangedCallback submitSearch;
  final OnChangedCallback changeSearch;
  Search({this.changeSearch, this.submitSearch});
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(left: 10.0),
      margin: new EdgeInsets.only(right: 5.0,),
      decoration: new BoxDecoration(
        color: new Color.fromRGBO(39, 37, 66, 1.0),
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Icon(
            Icons.search,
            color: Colors.white,
            size: 20.0,
          ),
          new Expanded(
            child: new Center(
              child: new Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 4.0,),
                height: 40.0,
                child: new TextField(
                  autofocus: true,
                  onChanged: (data) {
                    changeSearch(data);
                  },
                  onSubmitted: (item) {
                    submitSearch(item);
                  },
                  style: new TextStyle(fontSize: 15.0, color: Colors.white),
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintStyle: new TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      hintText: 'Search. . .'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SearchButton extends StatelessWidget {
  final Function pressed;

  SearchButton({ this.pressed});

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      icon: new Icon(
        Icons.search,
        size: 25.0,
        color: Colors.white,
      ),
      onPressed:this.pressed,
    );
  }
}
