import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/controllers/user_controllers.dart';
import 'package:unite/features/chat/screens/conversation/conversation_screen.dart';
import 'package:unite/utils/constants/colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userCtrl = Get.put(UserController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Chats"),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: UColors.primary,
              indicatorColor: UColors.primary,
              tabs: [
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
              StreamBuilder<QuerySnapshot>(
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
                        onTap: () => Get.to(ConversationScreen(
                          user: snapshot.data!.docs[index],
                        )),
                        child: ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data?.docs[index]['image']),
                              ),
                              Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: snapshot.data?.docs[index]
                                              ['isOnline']
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
              const Center(child: Text("Akram")),
            ],
          )),
    );
  }
}
