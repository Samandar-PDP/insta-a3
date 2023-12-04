import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/manager/firebase_manager.dart';
import 'package:instagram_clone/model/message.dart';

class ChatManager {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance;
  final _storage = FirebaseStorage.instance;

  final _fManager = FirebaseManager();

  Future<void> sentTextMessage(String text, String receiverId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final messageId = _db.ref('chats').push().key;
    final senderId = _fManager.getUser()?.uid ?? "";
    final senderRoom = receiverId + senderId;
    final receiverRoom = senderId + receiverId;
    final now = DateTime.now().toLocal();
    final currentTime = "${now.hour}:${now.minute}, ${now.day}:${now.month}:${now.year}";
    final newMessage = Message(messageId, senderId, receiverId, text, null, 0, currentTime, false, null);
    _db.ref('chats/$senderRoom/messages/$messageId').set(newMessage.toJson());
    _db.ref('chats/$receiverRoom/messages/$messageId').set(newMessage.toJson());
  }

  Stream<DataSnapshot> getCurrentMessages(String receiverId) {
    final senderId = _fManager.getUser()?.uid ?? "";
    final room = receiverId + senderId;
    return _db.ref('chats/$room/messages').get().asStream();
  }

  Future<void> sentImageMessage(File file, String receiverId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final imageId = DateTime.now().microsecondsSinceEpoch.toString();
    final snapshot = await _storage.ref('chats_images/$imageId').putFile(file);
    final imageUrl = await snapshot.ref.getDownloadURL();

    final messageId = _db.ref('chats').push().key;
    final senderId = _fManager.getUser()?.uid ?? "";
    final senderRoom = receiverId + senderId;
    final receiverRoom = senderId + receiverId;
    final now = DateTime.now().toLocal();
    final currentTime = "${now.hour}:${now.minute}, ${now.day}:${now.month}:${now.year}";
    final newMessage = Message(messageId, senderId, receiverId, null, imageUrl, 1, currentTime, false, imageId);
    _db.ref('chats/$senderRoom/messages/$messageId').set(newMessage.toJson());
    _db.ref('chats/$receiverRoom/messages/$messageId').set(newMessage.toJson());
  }
}