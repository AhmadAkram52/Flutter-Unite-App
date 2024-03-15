import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unite/features/chat/controllers/inbox_controller.dart';
import 'package:unite/features/chat/screens/inbox/widgets/bottom_input_field.dart';
import 'package:unite/features/chat/screens/inbox/widgets/message_bubble.dart';
import 'package:unite/navigation_menu.dart';
import 'package:unite/utils/constants/enums.dart';
import 'package:unite/utils/constants/images_strings.dart';
import 'package:unite/utils/constants/text.dart';
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
                backgroundImage: AssetImage(UImages.user1),
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
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!.data();
                if (data != null) {
                  final senderId = data[UTexts.senderId];
                  final receiverName = data[UTexts.receiverName];
                  final senderName = data[UTexts.senderName];

                  if (senderId == FireHelpers.currentUserId) {
                    return Text(receiverName);
                  } else {
                    return Text(senderName);
                  }
                } else {
                  return const Text('Data is null');
                }
              } else {
                return const Text('No data available');
              }
            },
          ),
          subtitle: const Text("Last Active: "),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  height: 100,
                  child: const Row(
                    children: [
                      Icon(Iconsax.gallery),
                      Icon(Iconsax.camera),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
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
                        .collection(UTexts.messages)
                        .orderBy(UTexts.messageTime, descending: true)
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
                            padding:
                                const EdgeInsets.only(top: 12, bottom: 12) +
                                    const EdgeInsets.symmetric(horizontal: 12),
                            separatorBuilder: (_, __) => const SizedBox(
                                  height: 5,
                                ),
                            controller: chatController.scrollController,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return MessageBubbleView(
                                text: snapshot.data.docs[index]
                                    [UTexts.messageText],
                                context: context,
                                type: snapshot.data.docs[index]
                                            [UTexts.senderId] ==
                                        FireHelpers.currentUserId
                                    ? ChatMessageType.sent
                                    : ChatMessageType.received,
                                messageTime: snapshot
                                    .data.docs[index][UTexts.messageTime]
                                    .toDate(),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(UTexts.error),
                        );
                      } else {
                        return const Center(
                          child: Text(UTexts.noMessage),
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
