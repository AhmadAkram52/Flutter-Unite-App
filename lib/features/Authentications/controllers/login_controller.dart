import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/main.dart';
import 'package:unite/utils/helper/firebase_helper.dart';
import 'package:unite/utils/helper/helper_funtions.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool mailIsValid = true.obs;

  formValidation() async {
    await FirebaseHelpers.fireAuth
        .signOut()
        .then((value) => Get.snackbar("LogOut", "LogOut user."));
    final String email = mailController.text.toString();
    final String password = passwordController.text.toString();

    if (UHelpers.isValidEmail(email)) {
      mailIsValid.value = true;
      loginWithEmailAndPassword(email: email, password: password);
    } else {
      mailIsValid.value = false;
    }
  }

  loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseHelpers.fireAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Get.to(const NavigationMenu()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Please SignUp", "No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Login Failed", "Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
  }
}
