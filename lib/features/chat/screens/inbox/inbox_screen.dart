import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/controllers/inbox_controller.dart';
import 'package:unite/features/chat/screens/inbox/widgets/bottom_input_field.dart';
import 'package:unite/features/chat/screens/inbox/widgets/message_bubble.dart';
import 'package:unite/navigation_menu.dart';
import 'package:unite/utils/constants/enums.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

class InboxScreen extends StatelessWidget {
  final String inboxId;

  const InboxScreen({super.key, required this.inboxId});

  @override
  Widget build(BuildContext context) {
    final InboxController chatController = Get.put(InboxController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            NavigatorController.to.selectIndex.value = 1;
            Get.offAll(const NavigationMenu());
          },
        ),
        // centerTitle: false,
        titleSpacing: -25,
        title: ListTile(
          leading: Stack(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/image.png'
                    // user['image'].toString(),
                    ),
              ),
              Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: /*user['isOnline']*/
                          true ? Colors.green : Colors.grey,
                    ),
                    height: 10,
                    width: 10,
                  ))
            ],
          ),
          title: FutureBuilder(
            future: FireHelpers.chatsRef.doc(inboxId).get(),
            builder: (_,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Or any loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!.data();
                if (data != null) {
                  final senderId = data['senderId'];
                  final receiverName = data['receiverName'];
                  final senderName = data['senderName'];

                  if (senderId == FireHelpers.currentUserId) {
                    return Text(receiverName);
                  } else {
                    return Text(senderName);
                  }
                } else {
                  return Text('Data is null');
                }
              } else {
                return Text('No data available');
              }
            },
          ),
          subtitle: const Text("Last Active: "),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  chatController.focusNode.unfocus();
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: StreamBuilder(
                    stream: FireHelpers.chatsRef
                        .doc(inboxId)
                        .collection('messages')
                        .orderBy('messageTime', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          padding: const EdgeInsets.only(top: 12, bottom: 12) +
                              const EdgeInsets.symmetric(horizontal: 12),
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 5,
                          ),
                          controller: chatController.scrollController,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return MessageBubbleView(
                              text: snapshot.data.docs[index]['messageText'],
                              context: context,
                              type: snapshot.data.docs[index]['senderId'] ==
                                      FireHelpers.currentUserId
                                  ? ChatMessageType.sent
                                  : ChatMessageType.received,
                              messageTime: snapshot
                                  .data.docs[index]['messageTime']
                                  .toDate(),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      } else {
                        return const Center(
                          child: Text('no message'),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            BottomInputField(
              inboxId: inboxId,
            ),
          ],
        ),
      ),
    );
  }
}
