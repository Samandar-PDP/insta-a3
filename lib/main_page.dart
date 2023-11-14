import 'package:flutter/material.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _manager = FirebaseManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${_manager.getUser()?.email}",style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
