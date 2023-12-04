import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/manager/chat_manager.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/model/fb_user.dart';
import 'package:instagram_clone/model/message.dart';
import 'package:instagram_clone/widget/loading.dart';
import 'package:instagram_clone/widget/message_field.dart';
import 'package:instagram_clone/widget/receiver_message.dart';
import 'package:instagram_clone/widget/sender_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final FbUser? user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  final _chatManager = ChatManager();
  final _fManager = FirebaseManager();
  final _imagePicker = ImagePicker();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBar(widget.user),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _chatManager.getCurrentMessages(widget.user?.uid ?? ""),
                builder: (context, snapshot) {
                  final myUid = _fManager.getUser()?.uid;
                  if (snapshot.data != null &&
                      snapshot.data?.value != null) {
                    final List<Message> messageList = snapshot
                        .data!.children
                        .map((e) => Message.fromJson(
                        e.value as Map<Object?, Object?>))
                        .toList();
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messageList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final message = messageList[index];
                        if (message.senderId == myUid) {
                          return SenderMessage(
                              message: message,
                              onMessageClicked: () {},
                              onImageOpen: () {});
                        } else {
                          return ReceiverMessage(message: message);
                        }
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.done &&
                      snapshot.data?.value == null) {
                    return const Icon(CupertinoIcons.clock);
                  } else {
                    return const Loading();
                  }
                },
              ),
            ),
            MessageField(
              isLoading: _isLoading,
              controller: _controller,
              onImagePick: () {
                print('hehe');
                _launchImage();
            },
              onSend: () {
                _sendTextMessage();
              },
            )
          ],
        ),
      ),
    );
  }
  AppBar _topBar(FbUser? user) {
    return AppBar(
      centerTitle: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(
              user?.image ?? ""
            ),
          ),
          const Gap(20),
          Text(user?.nickname ?? "")
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.phone)),
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.video_camera)),
      ],
    );
  }
  void _sendTextMessage() {
    setState(() {
      _isLoading = true;
    });
    _chatManager.sentTextMessage(_controller.text, widget.user?.uid ?? '').then((value) {
      setState(() {
        _isLoading = false;
        _controller.text = "";
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      });
    });
  }
  void _launchImage() async {
    final file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(file != null) {
      setState(() {
        _isLoading = true;
      });
      _chatManager.sentImageMessage(File(file.path), widget.user?.uid ?? "").then((value)  {
        setState(() {
          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
          _isLoading = false;
        });
      });
    }
  }
}
