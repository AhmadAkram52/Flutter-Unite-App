import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/models/user_model.dart';

class UserController extends GetxController {
  List<UserModel> users = [];

  Future<List<UserModel>> getAllUsers() async {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users =
          users.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      // notifyListener();
    });
    return users;
  }
}
