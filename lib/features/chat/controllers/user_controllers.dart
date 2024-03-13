import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/models/user_model.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

class UserController extends GetxController {
  final users = FirebaseHelpers.fireStore.collection("Users").snapshots();
  List<UserModel> allUsers = [];

  Future<List<UserModel>> getAllUsers() async {
    FirebaseFirestore.instance
        .collection('Users')
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      allUsers =
          users.docs.map((doc) => UserModel.fromFireStore(doc.data())).toList();
    });
    return allUsers;
  }
}
