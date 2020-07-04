import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/categories.dart';
import '../screens/account.dart';

class BottomNavigator extends StatefulWidget {

  BottomNavigatorState createState() {
    return BottomNavigatorState();
  }
}

class BottomNavigatorState extends State<BottomNavigator> {

   var _currentScreen = 0;
   List<Widget> _screens = [
    Home(),
    Categories(),
    Account(),
   ];
 
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreen],
      bottomNavigationBar: 
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Categories'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              title: Text('Account'),
            ),
          ],
          currentIndex: _currentScreen,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          onTap: (int index) {
            setState(() {_currentScreen = index;});
          },
        ),
      );
    }

}
