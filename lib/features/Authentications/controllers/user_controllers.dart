import 'package:get/get.dart';
import 'package:unite/features/Authentications/models/user_model.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

class UserController extends GetxController {
  final users = FireHelpers.usersRef.snapshots();
  List<UserModel> allUsers = [];

  Future<List<UserModel>> getAllUsers() async {
    FireHelpers.usersRef
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      allUsers =
          users.docs.map((doc) => UserModel.fromFireStore(doc.data())).toList();
    });
    return allUsers;
  }
}
