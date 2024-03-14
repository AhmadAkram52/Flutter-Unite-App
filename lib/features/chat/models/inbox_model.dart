class InboxModel {
  final String user1Name;
  final String user1Id;
  final String user2name;
  final String user2Id;
  final String lastMessage;

  InboxModel(
      {required this.user1Name,
      required this.user1Id,
      required this.user2name,
      required this.user2Id,
      required this.lastMessage});

  factory InboxModel.formJson(Map<String, dynamic> json) {
    return InboxModel(
        user1Name: json['user1Name'],
        user1Id: json['user1Id'],
        user2name: json['user2name'],
        user2Id: json['user2Id'],
        lastMessage: json['lastMessage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user1Name': user1Name,
      'user1Id': user1Id,
      'user2name': user2name,
      'user2Id': user2Id,
    };
  }
}
