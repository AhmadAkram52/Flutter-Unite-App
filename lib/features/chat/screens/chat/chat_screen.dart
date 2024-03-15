import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/controllers/user_controllers.dart';
import 'package:unite/features/chat/controllers/chat_controller.dart';
import 'package:unite/features/chat/screens/chat/add_chat_screen.dart';
import 'package:unite/features/chat/screens/inbox/inbox_screen.dart';
import 'package:unite/utils/constants/colors.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userCtrl = Get.put(UserController());
    final ChatController chatCtrl = Get.put(ChatController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(const AddChatScreen());
            },
            child: const Icon(Icons.add),
          ),
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
                stream: FireHelpers.fireStore
                    .collection("Chats")
                    .where(Filter.or(
                        Filter('senderId',
                            isEqualTo: FireHelpers.currentUserId),
                        Filter('receiverId',
                            isEqualTo: FireHelpers.currentUserId)))
                    .snapshots(),
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
                          Get.to(InboxScreen(
                              inboxId: snapshot.data!.docs[index]['inboxId']));
                        },
                        child: ListTile(
                          leading: Stack(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/image.png'
                                        // snapshot.data?.docs[index]['image'],
                                        ),
                              ),
                              Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: true ? Colors.green : Colors.grey,
                                    ),
                                    height: 10,
                                    width: 10,
                                  ))
                            ],
                          ),
                          title: snapshot.data?.docs[index]['senderId'] ==
                                  FireHelpers.currentUserId
                              ? Text(snapshot.data?.docs[index]['receiverName'])
                              : Text(snapshot.data?.docs[index]['senderName']),
                          subtitle:
                              Text(snapshot.data?.docs[index]['lastMessage']),
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
