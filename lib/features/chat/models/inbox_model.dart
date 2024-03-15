import 'package:unite/utils/constants/text.dart';

class InboxModel {
  final String senderName;
  final String senderId;
  final String receiverName;
  final String receiverId;
  final String lastMessage;
  final String inboxId;
  final int messageCounter;

  InboxModel({
    required this.inboxId,
    required this.senderName,
    required this.senderId,
    required this.receiverName,
    required this.receiverId,
    required this.lastMessage,
    required this.messageCounter,
  });

  factory InboxModel.formJson(Map<String, dynamic> json) {
    return InboxModel(
      senderName: json[UTexts.senderName],
      senderId: json[UTexts.senderId],
      receiverName: json[UTexts.receiverName],
      receiverId: json[UTexts.receiverId],
      lastMessage: json[UTexts.lastMessage],
      inboxId: json[UTexts.inboxId],
      messageCounter: json[UTexts.messageCounter],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UTexts.senderName: senderName,
      UTexts.senderId: senderId,
      UTexts.receiverName: receiverName,
      UTexts.receiverId: receiverId,
      UTexts.lastMessage: lastMessage,
      UTexts.inboxId: inboxId,
      UTexts.messageCounter: messageCounter,
    };
  }
}
