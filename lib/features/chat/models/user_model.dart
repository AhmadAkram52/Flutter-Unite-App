class UserModel {
  final String uid;
  final String email;
  final String name;
  final String image;
  final DateTime lastActive;
  final bool isOnline;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.image,
      required this.lastActive,
      required this.isOnline});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['id'],
        email: json['email'],
        name: json['name'],
        image: json['image'],
        lastActive: json['lastActive'].toDate(),
        isOnline: json['isOnline'] ?? false,
      );
}
