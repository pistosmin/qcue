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
        title: Text('Category', style: TextStyle(color: Colors.orange[800])),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.orange[800]),
        elevation: 4.0,
        backgroundColor: Colors.orange[50],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40.0),
        child: OrientationBuilder(builder: (context, orientation) {
          return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 12.0 / 10.0,
              children: _generateGridItems().map((String value) {
                return _displayGridItem(value, context);
              }).toList());
        }),
      ),
      backgroundColor: Colors.orange[50],
    );
  }
}

Widget _generateGridIcons(String value, BuildContext context) {
  if (value == 'study') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.create, color: Colors.orange[800],size: 50.0,),
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
        icon: Icon(Icons.directions_bike, color: Colors.orange[800],size: 50.0,),
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
        icon: Icon(Icons.directions_run, color: Colors.orange[800],size: 50.0,),
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
        icon: Icon(Icons.map, color: Colors.orange[800],size: 50.0,),
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
        icon: Icon(Icons.fastfood, color: Colors.orange[800],size: 50.0,),
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
        icon: Icon(Icons.favorite, color: Colors.orange[800],size: 50.0,),
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
  } else if (value == 'music') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.audiotrack, color: Colors.orange[800],size: 50.0,),
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
  } else if (value == 'book') {
    return Container(
      child: IconButton(
        icon: Icon(Icons.book, color: Colors.orange[800],size: 50.0,),
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
  for (int i = 0; i < 8; i++) {
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
      gridItems.add('music');
    } else if (i == 6) {
      gridItems.add('book');
    } else if (i == 7) {
      gridItems.add('all');
    }
  }
  return gridItems;
}

Widget _displayGridItem(String value, BuildContext context) {
  return new Container(
    padding: new EdgeInsets.all(10.0),
    margin: EdgeInsets.all(3.0),
    decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.grey[700],
        ),
        borderRadius: BorderRadius.circular(
          10.0,
        )),
    child: new Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _generateGridIcons(value, context),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 13.0),
              child: new Text(value, style: TextStyle(color: Colors.orange[800],fontSize: 20.0),),
            ),
          ],
        ),
      ),
    ),
  );
}
