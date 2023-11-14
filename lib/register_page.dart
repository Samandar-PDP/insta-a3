import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/main_page.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/widget/loading.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _picker = ImagePicker();
  XFile? _xFile;

  final _manager = FirebaseManager();

  bool _isLoading = false;
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  void _register() {
    setState(() {
      _isLoading = true;
    });
    _manager.register(
      _username.text,
      _email.text,
      _password.text,
      File(_xFile?.path ?? "")
    ).then((value) {
      if(value == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")));
        Navigator.of(context)
            .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MainPage()), (route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error $value")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color(0xff133e80),
                  Color(0xffad104c),
                ],
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Center(
                  child: ListView(
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: Text('Instagram',
                            style: GoogleFonts.dancingScript(
                                fontSize: 45, color: Colors.white)),
                      ),
                      const SizedBox(height: 50),
                      _xFile == null ? InkWell(
                        onTap: () async {
                          _xFile = await _picker.pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.image,color: Colors.white,size: 100,),
                        ),
                      ) : CircleAvatar(
                        radius: 60,
                        foregroundImage: FileImage(File(_xFile?.path ?? "")),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _username,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: const TextStyle(color: Colors.white70),
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _email,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.white70),
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _password,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white70),
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _isLoading ? const Loading() : InkWell(
                        onTap: _register,
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey,width: 2)
                          ),
                          child: const Center(
                            child: Text("Register",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Already have an account? Sign In",style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}