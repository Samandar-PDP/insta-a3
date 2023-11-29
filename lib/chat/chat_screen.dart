import 'package:flutter/material.dart';
import 'package:instagram_clone/model/fb_user.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final FbUser? user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _topBar(widget.user),
      ),
    );
  }
  Widget _topBar(FbUser? user) {
    return Text(user?.nickname ?? "");
  }
}
