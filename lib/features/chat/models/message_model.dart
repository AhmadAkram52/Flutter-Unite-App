import 'package:unite/utils/constants/text.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final DateTime messageTime;
  final String messageText;
  final String messageType;

  MessageModel(
      {required this.senderId,
      required this.messageType,
      required this.receiverId,
      required this.messageTime,
      required this.messageText});

  factory MessageModel.fromFireStore(Map<String, dynamic> json) => MessageModel(
        senderId: json[UTexts.senderId],
        receiverId: json[UTexts.receiverId],
        messageTime: json[UTexts.messageTime],
        messageType: json[UTexts.messageType],
        messageText: json[UTexts.messageText],
      );

  Map<String, dynamic> toFireStore() {
    return {
      UTexts.senderId: senderId,
      UTexts.receiverId: receiverId,
      UTexts.messageTime: messageTime,
      UTexts.messageText: messageText,
      UTexts.messageType: messageType,
    };
  }
}
