import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/controllers/user_controllers.dart';
import 'package:unite/features/chat/controllers/chat_controller.dart';
import 'package:unite/features/chat/screens/chat/add_chat_screen.dart';
import 'package:unite/features/chat/screens/inbox/inbox_screen.dart';
import 'package:unite/utils/constants/colors.dart';
import 'package:unite/utils/constants/images_strings.dart';
import 'package:unite/utils/constants/text.dart';
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
            title: const Text(UTexts.chats),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: UColors.primary,
              indicatorColor: UColors.primary,
              tabs: [
                Tab(
                  text: UTexts.quests,
                ),
                Tab(
                  text: UTexts.personal,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FireHelpers.chatsRef
                    .where(Filter.or(
                        Filter(UTexts.senderId,
                            isEqualTo: FireHelpers.currentUserId),
                        Filter(UTexts.receiverId,
                            isEqualTo: FireHelpers.currentUserId)))
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(UTexts.error),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Get.to(InboxScreen(
                              inboxId: snapshot.data!.docs[index]
                                  [UTexts.inboxId]));
                        },
                        child: ListTile(
                          leading: Stack(
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(UImages.user1),
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
                          title: snapshot.data?.docs[index][UTexts.senderId] ==
                                  FireHelpers.currentUserId
                              ? Text(snapshot.data?.docs[index]
                                  [UTexts.receiverName])
                              : Text(snapshot.data?.docs[index]
                                  [UTexts.senderName]),
                          subtitle: snapshot.data?.docs[index]
                                      [UTexts.lastMessageType] ==
                                  UTexts.image
                              ? const Text("Image")
                              : Text(snapshot.data?.docs[index]
                                  [UTexts.lastMessage]),
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
                    return const Text(UTexts.error);
                  }
                },
              ),
              const Center(child: Text("Akram")),
            ],
          )),
    );
  }
}
