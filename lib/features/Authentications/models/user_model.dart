import 'package:unite/utils/constants/text.dart';

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

  factory UserModel.fromFireStore(Map<String, dynamic> json) => UserModel(
        uid: json[UTexts.uid],
        name: json[UTexts.name],
        email: json[UTexts.email],
        password: json[UTexts.password],
        image: json[UTexts.image],
        lastActive: json[UTexts.lastActive].toDate(),
        isOnline: json[UTexts.isOnline] ?? false,
      );

  Map<String, dynamic> toFireStore() {
    return {
      UTexts.uid: uid,
      UTexts.name: name,
      UTexts.email: email,
      UTexts.password: password,
      UTexts.image: image,
      UTexts.lastActive: lastActive,
      UTexts.isOnline: isOnline,
    };
  }
}
