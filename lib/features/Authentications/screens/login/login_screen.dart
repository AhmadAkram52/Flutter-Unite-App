import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/controllers/login_controller.dart';
import 'package:unite/features/Authentications/screens/signup/signup_screen.dart';
import 'package:unite/utils/constants/colors.dart';
import 'package:unite/utils/constants/images_strings.dart';
import 'package:unite/utils/constants/text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCtrl = Get.put(LoginController());
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(UImages.loginBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: Get.width * .8,
                child: Obx(() {
                  return TextFormField(
                    controller: loginCtrl.mailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: UTexts.email,
                      errorText: loginCtrl.mailIsValid.value
                          ? null
                          : UTexts.invalidMail,
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  );
                })),
            const SizedBox(height: 20),
            SizedBox(
                width: Get.width * .8,
                child: TextFormField(
                  controller: loginCtrl.passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: UTexts.password,
                    fillColor: Colors.grey,
                    filled: true,
                  ),
                )),
            const SizedBox(height: 20),
            SizedBox(
                width: Get.width * .8,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: UColors.primary,
                      foregroundColor: Colors.white),
                  onPressed: () => loginCtrl.formValidation(),
                  icon: const Icon(Icons.phone_android),
                  label: const Text(UTexts.logIn),
                )),
            SizedBox(
                width: Get.width * .8,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: UColors.primary,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Get.to(const SignupScreen());
                    loginCtrl.passwordController.clear();
                    loginCtrl.mailController.clear();
                  },
                  icon: const Icon(Icons.phone_android),
                  label: const Text(UTexts.signUp),
                )),
          ],
        ),
      ),
    );
  }
}
