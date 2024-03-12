import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/screens/verify_code.dart';
import 'package:unite/main.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

class SignupController extends GetxController {
  final TextEditingController numController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  RxString phoneNumber = "".obs;
  RxString dailCode = "".obs;
  RxBool numIsValid = true.obs;

  toSubmit(BuildContext context) {
    if (numController.text.length != 10) {
      numIsValid.value = false;
    } else {
      phoneNumber.value = numController.text.toString();
      final String fullNumber = "${dailCode.value}${phoneNumber.value}";
      Get.defaultDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Edit"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Get.to(CodeVerifyScreen(verificationId: "verificationId"));
              sentCodeUsingNumber(phoneNumber: fullNumber);
            },
            child: const Text("Yes"),
          ),
        ],
        title: "Number Confirmation",
        middleText: "$fullNumber \n Is your phone number above correct?",
      );
    }
  }

  sentCodeUsingNumber({required String phoneNumber}) {
    FirebaseHelpers.fireAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          Get.snackbar("Error", "$e");
          print("Ahmad Phone Error::::: $e");
        },
        codeSent: (String verificationId, int? token) {
          Get.to(CodeVerifyScreen(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (e) {
          Get.snackbar("TimeOut", e);
          print(" Ahmad TimeOut::::: $e");
        });
  }

  verifyCode({verificationId, smsCode}) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      await FirebaseHelpers.fireAuth
          .signInWithCredential(credential)
          .then((value) => Get.to(const NavigationMenu()));
    } catch (e) {
      Get.snackbar("Error", '$e');
      print(" Ahmad Code Error::::: $e");
    }
  }
}
