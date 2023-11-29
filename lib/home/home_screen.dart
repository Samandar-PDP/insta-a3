import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/chat/chat_screen.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/widget/loading.dart';
import 'package:instagram_clone/widget/post_item.dart';
import 'package:instagram_clone/widget/story_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _manager = FirebaseManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Instagram",
          style: GoogleFonts.dancingScript(fontSize: 34, color: Colors.white), /// 2
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: SizedBox(height: 100,width: double.infinity,
          child: FutureBuilder(
            future: _manager.getAllUsers(),
            builder: (context, snapshot) {
              if(snapshot.data != null && snapshot.data?.isNotEmpty == true) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final currentUser = snapshot.data![index];
                    if(index == 0) {
                      return _buildBox();
                    } else {
                      return StoryItem(fbUser: snapshot.data![index - 1], onClick: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(builder: (context) => ChatScreen(user: currentUser))
                        );
                      });
                    }
                  },
                );
              } else if(snapshot.data?.isEmpty == true){
                return const Center(child: Text("No users"),);
              } else {
                return const Loading();
              }
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
      body: FutureBuilder(
        future: _manager.getAllPosts(),
        builder: (context, snapshot) {
          if(snapshot.data != null && snapshot.data?.isNotEmpty == true) {
            final reversedList = snapshot.data?.reversed.toList();
            return ListView.separated(
              separatorBuilder: (context, index) => const Gap(25),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PostItem(post: reversedList![index]);
              },
            );
          } else if(snapshot.data?.isEmpty == true){
            return const Center(child: Icon(CupertinoIcons.clock));
          } else {
            return const Loading();
          }
        },
      ),
    );
  }

  Widget _buildBox() {
    return Stack(
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(50),
          child: Container(
            margin: const EdgeInsets.all(8), /// ozgardi
            width: 80,
            height: 80,
            decoration:
            BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white,width: 2)),
            child: const Icon(CupertinoIcons.person_circle),
          ),
        ),
        Positioned(
            right: 5,
            bottom: 15, /// 1
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
