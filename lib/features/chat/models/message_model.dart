import 'package:unite/utils/constants/text.dart';

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
        senderId: json[UTexts.senderId],
        receiverId: json[UTexts.receiverId],
        messageTime: json[UTexts.messageTime],
        messageText: json[UTexts.messageText],
      );

  Map<String, dynamic> toFireStore() {
    return {
      UTexts.senderId: senderId,
      UTexts.receiverId: receiverId,
      UTexts.messageTime: messageTime,
      UTexts.messageText: messageText,
    };
  }
}
