import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/controllers/user_controllers.dart';
import 'package:unite/features/chat/controllers/chat_controller.dart';
import 'package:unite/utils/constants/colors.dart';

class AddChatScreen extends StatelessWidget {
  const AddChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatCtrl = Get.put(ChatController());
    final UserController userCtrl = Get.put(UserController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Chats"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: userCtrl.users,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    chatCtrl.createChat(snapshot.data!.docs[index]);
                  },
                  child: ListTile(
                    leading: Stack(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/image.png'
                              // snapshot.data?.docs[index]['image'],
                              ),
                        ),
                        Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: snapshot.data?.docs[index]['isOnline']
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              height: 10,
                              width: 10,
                            ))
                      ],
                    ),
                    title: Text(snapshot.data?.docs[index]['name']),
                    subtitle: const Text("UserName: Last Message"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("12:12"),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
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
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                  color: Colors.grey,
                  height: 1,
                ),
              );
            } else {
              return const Text("Ahmad");
            }
          },
        ),
      ),
    );
  }
}
