import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/screens/login/login_screen.dart';
import 'package:unite/navigation_menu.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      var currentUser = FirebaseHelpers.fireAuth.currentUser;
      if (currentUser != null) {
        Get.offAll(const NavigationMenu());
      } else {
        Get.offAll(const LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF007FBF),
        ),
        child: Center(
          child: Image.asset("assets/images/Unite Logo.png"),
        ),
      ),
    );
  }
}
