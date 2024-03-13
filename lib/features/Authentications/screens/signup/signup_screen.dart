import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/controllers/signup_controller.dart';
import 'package:unite/features/Authentications/screens/login/login_screen.dart';
import 'package:unite/utils/constants/colors.dart';
import 'package:unite/utils/helper/helper_funtions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupCtrl = Get.put(SignupController());
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * .8,
              child: TextFormField(
                controller: signupCtrl.nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Name',
                  errorText: signupCtrl.nameController.text.isEmpty
                      ? null
                      : "Please fill This Field!",
                  fillColor: Colors.grey,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: Get.width * .8,
                child: Obx(() {
                  return TextFormField(
                    controller: signupCtrl.mailController,
                    onChanged: (email) {
                      if (UHelpers.isValidEmail(email)) {
                        signupCtrl.mailIsValid.value = true;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Email',
                      errorText:
                          signupCtrl.mailIsValid.value ? null : "invalid mail",
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  );
                })),
            const SizedBox(height: 20),
            SizedBox(
                width: Get.width * .8,
                child: Obx(() {
                  return TextFormField(
                    controller: signupCtrl.passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Password',
                      errorText: signupCtrl.passIsValid.value
                          ? null
                          : "Password is Not Match",
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  );
                })),
            const SizedBox(height: 20),
            SizedBox(
                width: Get.width * .8,
                child: Obx(() {
                  return TextFormField(
                    controller: signupCtrl.rePasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Re-Password',
                      errorText: signupCtrl.passIsValid.value
                          ? null
                          : "Password is Not Match",
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  );
                })),
            const SizedBox(height: 20),
            SizedBox(
                width: Get.width * .8,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: UColors.primary,
                      foregroundColor: Colors.white),
                  onPressed: () => signupCtrl.formValidation(),
                  icon: const Icon(Icons.phone_android),
                  label: const Text("SignUp"),
                )),
            TextButton(
              onPressed: () {
                Get.to(const LoginScreen());
                signupCtrl.rePasswordController.clear();
                signupCtrl.passwordController.clear();
                signupCtrl.mailController.clear();
                signupCtrl.nameController.clear();
              },
              child: const Text(
                "Login!",
                style: TextStyle(
                    color: Colors.black, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
