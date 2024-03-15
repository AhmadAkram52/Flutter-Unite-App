import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/screens/login/login_screen.dart';
import 'package:unite/features/Authentications/screens/splash_screen.dart';
import 'package:unite/firebase_options.dart';
import 'package:unite/utils/constants/lists.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider:
        ReCaptchaV3Provider('6LeIrJYpAAAAAHz0HuicVkLiyH6NNGesya7RY7cL'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  runApp(const UniteApp());
  // runApp(MyApp());
}

class UniteApp extends StatelessWidget {
  const UniteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      supportedLocales: ULists.listOfLocale,
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Home Screen")),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Notification Screen")),
    );
  }
}

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Add Screen")),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          FireHelpers.fireAuth.signOut().then((value) => {
                Get.offAll(const LoginScreen()),
              });
        },
        child: const Text("LogOut"),
      )),
    );
  }
}
