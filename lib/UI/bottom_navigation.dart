import 'package:flutter/material.dart';
import 'package:provider_bloc_test/UI/home_screen.dart';

import 'friend_screen.dart';
import 'profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Body();
  }
}

class Body extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int page) {
    if (page == null) {
      return HomeScreen();
    }
    switch (page) {
      case 0:
        return HomeScreen();
      case 1:
        return FriendScreen();
      case 2:
        return ProfileScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Bảng tin'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_outlined),
              title: Text('Bạn bè')),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Cá nhân'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
