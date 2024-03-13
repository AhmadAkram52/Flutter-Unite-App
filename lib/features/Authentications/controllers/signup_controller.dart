import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/models/user_model.dart';
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
      if (UHelpers.isValidEmail(email)) {
        mailIsValid.value = true;
        if (password == rePassword) {
          passIsValid.value = true;
          Get.snackbar("Success", "Ahmad Akram");
          print("Ahmad:::::::::::::::Success");
          signUpWithEmailAndPass(mail: email, password: password);
        } else {
          passIsValid.value = false;
        }
      } else {
        mailIsValid.value = false;
      }
    } else {}
  }

  signUpWithEmailAndPass(
      {required String mail, required String password}) async {
    try {
      await FirebaseHelpers.fireAuth
          .createUserWithEmailAndPassword(
        email: mail,
        password: password,
      )
          .then((value) async {
        print("Ahmad ::::::::");
        UserModel userModel = UserModel(
            uid: FirebaseHelpers.fireAuth.currentUser!.uid,
            email: mail,
            name: name,
            image: 'none',
            lastActive: DateTime.now(),
            isOnline: true,
            password: password);
        await FirebaseHelpers.fireStore
            .collection("Users")
            .doc(FirebaseHelpers.fireAuth.currentUser!.uid)
            .set(userModel.toFireStore())
            .then((value) {
          Get.snackbar("Success SignUp", "User Success Created");
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
      print('Ahmad :::$e');
    }
  }

// toSubmit(BuildContext context) {
//   if (numController.text.length != 10) {
//     numIsValid.value = false;
//   } else {
//     phoneNumber.value = numController.text.toString();
//     final String fullNumber = "${dailCode.value}${phoneNumber.value}";
//     Get.defaultDialog(
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text("Edit"),
//         ),
//         TextButton(
//           onPressed: () {
//             isLoading.value = true;
//             Navigator.pop(context);
//             // Get.to(CodeVerifyScreen(verificationId: "verificationId"));
//             sentCodeUsingNumber(phoneNumber: fullNumber);
//           },
//           child: const Text("Yes"),
//         ),
//       ],
//       title: "Number Confirmation",
//       middleText: "$fullNumber \n Is your phone number above correct?",
//     );
//   }
// }

// sentCodeUsingNumber({required String phoneNumber}) {
//   FirebaseHelpers.fireAuth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       timeout: const Duration(seconds: 10),
//       verificationCompleted: (_) {},
//       verificationFailed: (e) {
//         isLoading.value = false;
//         Get.snackbar("Error", "$e");
//         print("Ahmad Phone Error::::: $e");
//       },
//       codeSent: (String verificationId, int? token) {
//         isLoading.value = false;
//         Get.to(CodeVerifyScreen(verificationId: verificationId));
//       },
//       codeAutoRetrievalTimeout: (e) {
//         isLoading.value = false;
//         Get.snackbar("TimeOut", e);
//         print(" Ahmad TimeOut::::: $e");
//       });
// }

// verifyCode({verificationId, smsCode}) async {
//   final credential = PhoneAuthProvider.credential(
//       verificationId: verificationId, smsCode: smsCode);
//   try {
//     await FirebaseHelpers.fireAuth.signInWithCredential(credential);
//     Get.to(const NavigationMenu());
//   } catch (e) {
//     Get.snackbar("Error", '$e');
//     print(" Ahmad Code Error::::: $e");
//   }
// }
}
