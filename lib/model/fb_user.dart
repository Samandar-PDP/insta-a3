class FbUser {
  String? uid;
  String? image;
  String? username;
  String? email;
  String? password;
  String? nickname;
  int postCount = 0; /// 1
  int followingCount = 0;
  int followersCount = 0;

  FbUser.user({ /// 2
    required this.uid,
    required this.image,
    required this.username,
    required this.email,
    required this.password,
    required this.nickname,
    required this.postCount, /// 3
    required this.followingCount,
    required this.followersCount});
  FbUser();

  FbUser.fromJson(Map<Object?, Object?> json) : /// 1
      uid = json['uid'].toString(),
      image = json['image'].toString(),
      email = json['email'].toString(),
      username = json['username'].toString(),
  nickname = json['nickname'].toString(),
      password = json['password'].toString(),
  postCount = int.tryParse(json['post_count'].toString()) ?? 0, /// 4
  followersCount = int.tryParse(json['follower_count'].toString()) ?? 0,
  followingCount = int.tryParse(json['following_count'].toString()) ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'image': image,
      'username': username,
      'email': email,
      'password': password,
      'nickname': nickname,
      'post_count': postCount, /// 5
      'follower_count': followersCount,
      'following_count': followingCount
    };
  }
}