import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/screen/main_screen.dart';
import 'package:instagram_clone/util/message.dart';
import 'package:instagram_clone/widget/loading.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final _picker = ImagePicker();
  XFile? _image;
  final _textController = TextEditingController();

  final _manager = FirebaseManager();
  bool _isLoading = false;

  void _uploadPost()  {
    setState(() {
      _isLoading = true;
    });
    _manager.uploadPost(
      Post.post(
          id: null,
          ownerId: null,
          image: _image?.path ?? "",
          text: _textController.text,
          uploadedTime: null,
          likeCount: 0,
          viewCount: 0,
          imageName: null
      )
    ).then((value) {
      Navigator.of(context)
          .pushAndRemoveUntil(CupertinoPageRoute(
          builder: (context) => const MainScreen()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add Screen"),
        actions: [
          _isLoading ? const Loading() :
          CupertinoButton(child: const Icon(CupertinoIcons.add), onPressed: () {
            if(_image != null && _textController.text.isNotEmpty) {
              _uploadPost();
            } else {
              showErrorMessage(context, 'Enter data');
            }
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Add image to your post",style:
            GoogleFonts.roboto(fontSize: 20,color: Colors.white)),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                _image = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {});
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: _image == null ? const Icon(CupertinoIcons.photo)
                 : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(File(_image?.path ?? ""),fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text('Write text to your post',style: GoogleFonts.roboto(fontSize: 20,color: Colors.white)),
            const SizedBox(height: 10),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Text',
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white,width: 2)
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.indigoAccent,width: 2)
                ),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white,width: 2)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
