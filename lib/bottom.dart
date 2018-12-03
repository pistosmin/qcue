import 'package:flutter/material.dart';

class BottomNavi extends StatefulWidget{
  @override
  BottomNaviState createState() {
    return BottomNaviState();
  }
}
class BottomNaviState extends State<BottomNavi>{
  int _currentIndex = 0;
  
    void onTabTapped(int index) {
    setState(() {
          _currentIndex = index;
        });
      }
    
      @override
      Widget build(BuildContext context){
        return BottomNavigationBar(
            onTap: onTabTapped, // new
            currentIndex: _currentIndex, // new
            // fixedColor: Colors.cyan,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('List'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text('Add'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          );
      }
  
}