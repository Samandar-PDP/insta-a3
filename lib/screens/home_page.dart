import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Instagram",style: GoogleFonts.dancingScript(
          fontSize: 34,
          color: Colors.white
        ),),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart)),
          Badge.count(
            count: 10,
            child: IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.chat_bubble)),
          ),
        ],
      ),
    );
  }
}
