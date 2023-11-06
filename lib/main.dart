import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const InstagramApp());
}
class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
    );
  }
}
