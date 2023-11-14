import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FirebaseManager {
  final _auth = FirebaseAuth.instance; // login | register

  final _storage = FirebaseStorage.instance; // image | file
  final _realTime = FirebaseDatabase.instance; // chatting
  final _db = FirebaseFirestore.instance; // save users data

  User? getUser() {
    return _auth.currentUser;
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(response);
      return 'Success';
    } catch(e) {
      return 'Error';
    }
  }
  Future<String> register(
      String username,
      String email,
      String password,
      File image // -> dart:io dan bo'lishi kerak!!!
      ) async {
    try {
      final imageName = DateTime.now().microsecondsSinceEpoch;
      final uploadTask = await _storage.ref('user_images/$imageName').putFile(image);
      final imageUri = await uploadTask.ref.getDownloadURL();
      final registerResponse =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final newUser = {
        'uid': '${registerResponse.user?.uid}',
        'username': username,
        'email': email,
        'password': password,
        'image': imageUri
      };
      final userId = _realTime.ref('users').push().key;
      await _realTime.ref('users/$userId').set(newUser);
      return 'Success';
    } catch(e) {
      debugPrint(e.toString());
      return 'Error';
    }
  }
}