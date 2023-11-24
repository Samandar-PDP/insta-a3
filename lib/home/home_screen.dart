import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Instagram",
          style: GoogleFonts.dancingScript(fontSize: 34, color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: SizedBox(height: 100,width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return _buildBox('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg');
            },
          ))
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
          Badge.count(
            count: 2,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.chat_bubble_text),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildBox(String imageUrl) {
    return Stack(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration:
              const BoxDecoration(shape: BoxShape.circle),
          child: CircleAvatar(
            foregroundImage: NetworkImage(imageUrl),
          ),
        ),
        Positioned(
            right: 0,
            bottom: 30,
            child: Container(
              height: 24,
              width: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
              ),
              child: const Icon(CupertinoIcons.add_circled,color: Colors.white),
            ))
      ],
    );
  }
}
