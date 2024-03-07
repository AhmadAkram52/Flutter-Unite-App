import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/models/user_model.dart';
import 'package:unite/features/chat/screens/conversation/conversation_screen.dart';
import 'package:unite/utils/constants/colors.dart';
import 'package:unite/utils/constants/images_strings.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<UserModel> users = [
      UserModel(
          uid: '1',
          email: 'ahmadg34@gmail.com',
          name: "Ahmad Akram",
          image: UImages.user1,
          lastActive: DateTime.now(),
          isOnline: true),
      UserModel(
          uid: '2',
          email: 'ahmadg34@gmail.com',
          name: "Ammar Akram",
          image: UImages.user1,
          lastActive: DateTime.now(),
          isOnline: true),
      UserModel(
          uid: '3',
          email: 'ahmadg34@gmail.com',
          name: "Umair",
          image: UImages.user1,
          lastActive: DateTime.now(),
          isOnline: true),
      UserModel(
          uid: '4',
          email: 'ahmadg34@gmail.com',
          name: "Zeeshan Ahmad",
          image: UImages.user1,
          lastActive: DateTime.now(),
          isOnline: true),
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Chats"),
            centerTitle: true,
            bottom: TabBar(
              labelColor: UColors.primary,
              indicatorColor: UColors.primary,
              tabs: const [
                Tab(
                  text: "Quests",
                ),
                Tab(
                  text: "Personal",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Get.to(ConversationScreen(
                    user: users[index],
                  )),
                  child: ListTile(
                    leading: Image(image: AssetImage(users[index].image)),
                    title: Text(users[index].name),
                    subtitle: const Text("UserName: Last Message"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("12:12"),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: UColors.primary,
                          ),
                          child: const Text(
                            "1",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Center(child: Text("Akram")),
            ],
          )),
    );
  }
}
