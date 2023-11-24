class Post{
  String? id;
  String? ownerId;
  String? image;
  String? text;
  String? uploadedTime;
  int? likeCount;
  int viewCount = 0; /// 1
  String? imageName; /// 2

  Post.post(
  {
    required this.id,
    required this.ownerId,
    required this.image,
    required this.text,
    required this.uploadedTime,
    required this.likeCount,
    required this.viewCount, /// 3
    required this.imageName
  }/// 4
      );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'image': image,
      'text': text,
      'time': uploadedTime,
      'like_count': likeCount,
      'view_count': viewCount, /// 5
      'image_name': imageName /// 6
    };
  }
  Post.fromJson(Map<Object?, Object?> json) :
        id = json['id'].toString(),
        ownerId = json['owner_id'].toString(),
        image = json['image'].toString(),
        text = json['text'].toString(),
        uploadedTime = json['time'].toString(),
        likeCount = int.tryParse(json['like_count'].toString()) ?? 0,
       viewCount = int.tryParse(json['view_count'].toString()) ?? 0, /// 7
       imageName = json['image_name'].toString(); /// 8
}