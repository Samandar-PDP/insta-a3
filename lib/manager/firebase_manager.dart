import 'dart:io';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/fb_user.dart';
import '../model/post.dart';

class FirebaseManager {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseDatabase.instance;
  final _storage = FirebaseStorage.instance;

  User? getUser() {
    return _auth.currentUser;
  }

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch(e) {
      return "Error";
    }
  }
  Future<String> register(
      String username,
      String email,
      String nickname, /// mana !!!
      String password,
      File image
      ) async {
    try {
      final user =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final fileName = DateTime.now().microsecondsSinceEpoch;
      final uploadTask = await _storage.ref('user_images/$fileName').putFile(image);
      final imageUri = await uploadTask.ref.getDownloadURL();
      final newUser = {
        'uid': user.user?.uid,
        'username': username,
        'email': email,
        'nickname': nickname, /// mana 2 !!!
        'password': password,
        'image': imageUri
      };
      final id = getUser()?.uid ?? _db.ref('users').push().key; /// mana
      await _db.ref('users/$id').set(newUser);
      return 'Success';
    } catch(e) {
      print(e.toString());
      return 'Error';
    }
  }
 /// import qil
  Future<FbUser> getCurrentUser() async {
    final id = getUser()?.uid ?? "";
    final snapshot = await _db.ref('users').child(id).get();
    final map = snapshot.value as Map<Object?, Object?>;
    final postList = await getMyPosts();
    return FbUser
        .user(
        uid: map['uid'].toString(),
        image: map['image'].toString(),
        username: map['username'].toString(),
        email: map['email'].toString(),
        password: map['password'].toString(),
        nickname: map['nickname'].toString(),
      postCount: postList.length,
      followersCount: int.tryParse(map['followers_count'].toString()) ?? 0,
      followingCount: int.tryParse(map['following_count'].toString()) ?? 0,
     );
  }
  Future<void> logOut() async {
    await _auth.signOut();
  }
  Future<void> uploadPost(Post post) async {
    final id = _db.ref('posts').push().key;
    final imageName = DateTime.now().microsecondsSinceEpoch.toString(); /// o'zgardi
    final uploadTask = await _storage.ref('post_images/$imageName')
        .putFile(File(post.image ?? ""));
    final imageUri = await uploadTask.ref.getDownloadURL();
    final currentTime = DateTime.now().toLocal().toString();
    final newPost = {
      'id': id,
      'owner_id': getUser()?.uid,
      'uploaded_time': currentTime,
      'like_count': post.likeCount,
      'image': imageUri,
      'image_name': imageName,
      'text': post.text,
      'view_count': post.viewCount
    };
    await _db.ref('posts/$id').set(newPost);
  }
   /// o'zgardi
  Future<List<Post>> getMyPosts() async {
    final id = getUser()?.uid;
    final List<Post> postList = [];
    final snapshotData = await _db.ref('posts').get();
    for(var map in snapshotData.children) {
      final post = Post.fromJson(map.value as Map<Object?, Object?>);
      if(post.ownerId == id) {
        postList.add(post);
      }
    }
    return postList;
  }
  Future<void> deletePost(Post? post) async {
    await _storage.ref('post_images/${post?.imageName}').delete();
    await _db.ref('posts/${post?.id}').remove();
  }
}