class MessageModel {
  final String senderId;
  final String receiverId;
  final DateTime messageTime;
  final String messageText;

  MessageModel(
      {required this.senderId,
      required this.receiverId,
      required this.messageTime,
      required this.messageText});

  factory MessageModel.fromFireStore(Map<String, dynamic> json) => MessageModel(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        messageTime: json['messageTime'],
        messageText: json['messageText'],
      );

  Map<String, dynamic> toFireStore() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "messageTime": messageTime,
      "messageText": messageText,
    };
  }
}
