class UserModel {
  final String uid;
  final String email;
  final String password;
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
      required this.isOnline,
      required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        image: json['image'],
        lastActive: json['lastActive'].toDate(),
        isOnline: json['isOnline'] ?? false,
      );

  Map<String, dynamic> toFireStore() {
    return {
      "id": uid,
      "name": name,
      "email": email,
      "password": password,
      "image": image,
      "lastActive": lastActive,
      "isOnline": isOnline,
    };
  }
}
