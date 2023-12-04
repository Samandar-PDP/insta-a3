class Message {
  String? messageId;
  String? senderId;
  String? receiverId;
  String? textMessage;
  String? imageMessage;
  int type = 0;
  String? time;
  bool isRead = false;
  String? ownerImage;
  String? imageId;

  Message(
      this.messageId,
      this.senderId,
      this.receiverId,
      this.textMessage,
      this.imageMessage,
      this.type,
      this.time,
      this.isRead,
      this.imageId,
      );

  Message.fromJson(Map<Object?, Object?> json) :
        messageId = json['message_id'].toString(),
        senderId = json['sender_id'].toString(),
        receiverId = json['receiver_id'].toString(),
        textMessage = json['text_message'].toString(),
        imageMessage = json['image_message'].toString(),
        type = int.tryParse(json['type'].toString()) ?? 0,
        time = json['time'].toString(),
        isRead = bool.tryParse(json['is_read'].toString()) ?? false,
        imageId = json['image_id'].toString();

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'text_message': textMessage,
      'image_message': imageMessage,
      'type': type,
      'time': time,
      'is_read': isRead,
      'image_id': imageId
    };
  }
}