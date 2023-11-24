class FbUser {
  String? uid;
  String? image;
  String? username;
  String? email;
  String? password;
  String? nickname;

  FbUser.user(this.uid, this.image, this.username, this.email, this.password, this.nickname);
  FbUser();

  FbUser.fromJson(Map<String, dynamic> json) :
      uid = json['uid'],
      image = json['image'],
      email = json['email'],
      username = json['username'],
  nickname = json['nickname'],
      password = json['password'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'image': image,
      'username': username,
      'email': email,
      'password': password,
      'nickname': nickname
    };
  }
}