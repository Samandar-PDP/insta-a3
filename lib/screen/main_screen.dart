import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home/add_screen.dart';
import '../home/home_screen.dart';
import '../home/profile_screen.dart';
import '../home/reels_screen.dart';
import '../home/search_screen.dart';
import '../manager/firebase_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _manager = FirebaseManager();

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    AddScreen(),
    ReelsScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _manager.getCurrentUser();
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, /// mana 3
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.home)
          ),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.search)
          ),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.add_circled)
          ),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.videocam_circle)
          ),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(CupertinoIcons.profile_circled)
          ),
        ],
      ),
    );
  }
}
