import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color(0xff5d30b7),
                  Color(0xffa40f9c),
                ],
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    children: [

                    ],
                  ),
                )
              ],
            ),
        ),
        )
    );
  }
}
