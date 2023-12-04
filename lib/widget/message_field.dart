import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageField extends StatefulWidget {
  const MessageField({super.key, required this.isLoading, required this.controller, required this.onImagePick, required this.onSend});
  final TextEditingController controller;
  final void Function() onSend;
  final void Function() onImagePick;
  final bool isLoading;

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(color: Colors.white),
        onChanged: (v) => setState(() {}),
        decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.withAlpha(70),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          prefixIcon: IconButton(
            onPressed: widget.onImagePick,
            icon: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle
              ),
              child: const Icon(CupertinoIcons.photo,color: Colors.white,),
            ),
          ),
          hintText: 'Message...',
          suffixIcon: widget.isLoading ? const CupertinoActivityIndicator() : widget.controller.text.isEmpty ? IconButton(
            icon:const Icon(CupertinoIcons.mic_circle,color: Colors.white,size: 30,),
            onPressed: () {},
          ) : IconButton(
            icon:const Icon(CupertinoIcons.paperplane,color: Colors.blue,size: 30,),
            onPressed: widget.onSend,
          )
        ),
      ),
    );
  }
}
