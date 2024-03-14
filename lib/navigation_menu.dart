import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unite/features/chat/screens/chat/chat_screen.dart';
import 'package:unite/main.dart';

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
  static NavigatorController get to => Get.find();
  final RxInt selectIndex = 0.obs;
  final screen = const [
    HomeScreen(),
    ChatScreen(),
    AddScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
}
