import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/screens/signup/signup_screen.dart';
import 'package:unite/utils/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                width: Get.width * .8,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: UColors.primary,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Get.to(const SignupScreen());
                  },
                  icon: const Icon(Icons.phone_android),
                  label: const Text("Continue with SMS"),
                )),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
