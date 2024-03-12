import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unite/features/Authentications/screens/login/login_screen.dart';
import 'package:unite/features/chat/screens/chat/chat_screen.dart';
import 'package:unite/firebase_options.dart';
import 'package:unite/utils/constants/lists.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
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
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const LoginScreen(),
    );
  }
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigatorController ctrl = Get.put(NavigatorController());
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return NavigationBar(
          height: 80,
          onDestinationSelected: (index) => ctrl.selectIndex.value = index,
          selectedIndex: ctrl.selectIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.discover),
              label: '',
            ),
            NavigationDestination(icon: Icon(Iconsax.message), label: ''),
            NavigationDestination(icon: Icon(Iconsax.add_square), label: ''),
            NavigationDestination(icon: Icon(Iconsax.notification), label: ''),
            NavigationDestination(
                icon: Image(
                  image: AssetImage('assets/images/image.png'),
                  height: 28,
                ),
                label: ''),
          ],
        );
      }),
      body: Obx(() => ctrl.screen[ctrl.selectIndex.value]),
    );
  }
}

class NavigatorController extends GetxController {
  final RxInt selectIndex = 0.obs;
  final screen = const [
    HomeScreen(),
    ChatScreen(),
    AddScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
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
    return const Scaffold(
      body: Center(child: Text("Profile Screen")),
    );
  }
}
