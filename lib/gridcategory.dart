import 'package:flutter/material.dart';
import 'category.dart';

class GridCateogory extends StatefulWidget {
  @override
  GridCateogoryState createState() {
    return GridCateogoryState();
  }
}

class GridCateogoryState extends State<GridCateogory> {
  Widget gridSection(BuildContext context) {
    return new Expanded(
      flex: 1,
      child: new GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: _generateGridItems().map((String value) {
            return _displayGridItem(value, context);
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Center(
        child: OrientationBuilder(builder: (context, orientation) {
          return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 9.0,
              children: _generateGridItems().map((String value) {
                return _displayGridItem(value, context);
              }).toList());
        }),
      ),
    );
  }
}

Widget _generateGridIcons(String value, BuildContext context) {
  if (value == 'study') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.create),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(
                    category: value,
                  ),
            ),
          );
        },
      ),
    );
  } else if (value == 'sports') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.directions_bike),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(
                    category: value,
                  ),
            ),
          );
        },
      ),
    );
  } else if (value == 'diet') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.directions_run),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(
                    category: value,
                  ),
            ),
          );
        },
      ),
    );
  } else if (value == 'travel') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.map),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(
                    category: value,
                  ),
            ),
          );
        },
      ),
    );
  } else if (value == 'cook') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.fastfood),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(
                    category: value,
                  ),
            ),
          );
        },
      ),
    );
  } else if (value == 'all') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.favorite),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(
                    category: value,
                  ),
            ),
          );
        },
      ),
    );
  }
}

List<String> _generateGridItems() {
  List<String> gridItems = new List<String>();
  for (int i = 0; i < 6; i++) {
    if (i == 0) {
      gridItems.add('study');
    } else if (i == 1) {
      gridItems.add('sports');
    } else if (i == 2) {
      gridItems.add('diet');
    } else if (i == 3) {
      gridItems.add('travel');
    } else if (i == 4) {
      gridItems.add('cook');
    } else if (i == 5) {
      gridItems.add('all');
    }
  }
  return gridItems;
}

Widget _displayGridItem(String value, BuildContext context) {
  return new Container(
    // decoration: BoxDecoration(
    //   border: Border(
    //     top: BorderSide(width: 1.0, color: Colors.black),
    //     left: BorderSide(width: 1.0, color: Colors.black),
    //     right: BorderSide(width: 1.0, color: Colors.black),
    //     bottom: BorderSide(width: 1.0, color: Colors.black),
    //   ),
    // ),
    padding: new EdgeInsets.all(8.0),
    color: new Color.fromRGBO(217, 232, 245, 1),
    child: new Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            _generateGridIcons(value, context),
            new Text(value),
          ],
        ),
      ),
    ),
  );
}
