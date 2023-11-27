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

  FbUser.fromJson(Map<String, dynamic> json) :
      uid = json['uid'],
      image = json['image'],
      email = json['email'],
      username = json['username'],
  nickname = json['nickname'],
      password = json['password'],
  postCount = json['post_count'], /// 4
  followersCount = json['follower_count'],
  followingCount = json['following_count'];

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