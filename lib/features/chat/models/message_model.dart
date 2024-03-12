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
}
