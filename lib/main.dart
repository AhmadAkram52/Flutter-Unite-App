import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unite/features/chat/screens/chat/chat_screen.dart';
import 'package:unite/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const UniteApp());
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
      home: const NavigationMenu(),
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
