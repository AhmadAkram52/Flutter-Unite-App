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
      senderName: json['user1Name'],
      senderId: json['user1Id'],
      receiverName: json['user2name'],
      receiverId: json['user2Id'],
      lastMessage: json['lastMessage'],
      inboxId: json['inboxId'],
      messageCounter: json['messageCounter'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderName': senderName,
      'senderId': senderId,
      'receiverName': receiverName,
      'receiverId': receiverId,
      'lastMessage': lastMessage,
      'inboxId': inboxId,
      'messageCounter': messageCounter,
    };
  }
}
