import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/screens/add_page.dart';
import 'package:instagram_clone/screens/home_page.dart';
import 'package:instagram_clone/screens/profile_page.dart';
import 'package:instagram_clone/screens/reels_page.dart';
import 'package:instagram_clone/screens/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _manager = FirebaseManager();

  final List<Widget> _screens = const [
    HomePage(),
    SearchPage(),
    AddPage(),
    ReelsPage(),
    ProfilePage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.search),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.add),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.videocam_circle),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.profile_circled),
          ),
        ],
      ),
    );
  }
}
