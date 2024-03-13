class Message {
  final String senderId;
  final String receiverId;
  final DateTime messageTime;
  final String messageText;

  Message(
      {required this.senderId,
      required this.receiverId,
      required this.messageTime,
      required this.messageText});

  factory Message.fromFireStore(Map<String, dynamic> json) => Message(
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
