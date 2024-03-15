import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/models/user_model.dart';
import 'package:unite/navigation_menu.dart';
import 'package:unite/utils/helper/firebase_helper.dart';
import 'package:unite/utils/helper/helper_funtions.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  RxString phoneNumber = "".obs;
  RxString dailCode = "".obs;
  RxBool mailIsValid = true.obs;
  RxBool nameIsFill = true.obs;
  RxBool passIsValid = true.obs;
  RxBool isLoading = false.obs;

  formValidation() {
    final String name = nameController.text.toString();
    final String email = mailController.text.toString();
    final String password = passwordController.text.toString();
    final String rePassword = rePasswordController.text.toString();
    if (name.isNotEmpty) {
      nameIsFill.value = true;
      if (UHelpers.isValidEmail(email)) {
        mailIsValid.value = true;
        if (password == rePassword) {
          passIsValid.value = true;
          Get.snackbar("Success", "Ahmad Akram");
          print("Ahmad:::::::::::::::Success");
          signUpWithEmailAndPass(mail: email, password: password, name: name);
        } else {
          passIsValid.value = false;
        }
      } else {
        mailIsValid.value = false;
      }
    } else {
      nameIsFill.value = false;
    }
  }

  signUpWithEmailAndPass(
      {required String name,
      required String mail,
      required String password}) async {
    try {
      await FireHelpers.fireAuth
          .createUserWithEmailAndPassword(
        email: mail,
        password: password,
      )
          .then((value) async {
        UserModel userModel = UserModel(
            uid: FireHelpers.fireAuth.currentUser!.uid,
            email: mail,
            name: name,
            image: 'none',
            lastActive: DateTime.now(),
            isOnline: true,
            password: password);
        await FireHelpers.usersRef
            .doc(FireHelpers.fireAuth.currentUser!.uid)
            .set(userModel.toFireStore())
            .then((value) {
          clearTextController();
          Get.offAll(const NavigationMenu());
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Password Week", 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
            "Change Email", 'The account already exists for that email.');
      }
    } catch (e) {
      Get.snackbar(e.toString(), "");
    }
  }

  clearTextController() {
    rePasswordController.clear();
    passwordController.clear();
    mailController.clear();
    nameController.clear();
  }
}
