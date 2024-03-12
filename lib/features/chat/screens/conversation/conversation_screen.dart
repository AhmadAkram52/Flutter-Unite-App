import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unite/features/chat/controllers/conversation_controller.dart';
import 'package:unite/features/chat/screens/conversation/widgets/bottom_input_field.dart';
import 'package:unite/utils/constants/enums.dart';

class ConversationScreen extends StatelessWidget {
  final QueryDocumentSnapshot user;

  const ConversationScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final ConversationController chatController =
        Get.put(ConversationController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        // centerTitle: false,
        titleSpacing: -25,
        title: ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user['image'].toString(),
                ),
              ),
              Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: user['isOnline'] ? Colors.green : Colors.grey,
                    ),
                    height: 10,
                    width: 10,
                  ))
            ],
          ),
          title: Text(user['name']),
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
                  child:
                      // Obx(() {
                      //   // var chatList = chatController.chatList.reversed.toList();
                      //   return
                      ListView.separated(
                    shrinkWrap: true,
                    reverse: true,
                    padding: const EdgeInsets.only(top: 12, bottom: 12) +
                        const EdgeInsets.symmetric(horizontal: 12),
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 2,
                    ),
                    controller: chatController.scrollController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return getBubbleView(
                        text:
                            "Ahmad Akram, Ahmad Akram,Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram,",
                        context: context,
                        type: index % 2 == 0
                            ? ChatMessageType.received
                            : ChatMessageType.sent,
                      );
                    },
                    //   );
                    // }
                  ),
                ),
              ),
            ),
            const BottomInputField(),
          ],
        ),
      ),
    );
  }

  getBubbleView({
    required BuildContext context,
    required String text,
    required ChatMessageType type,
  }) {
    return ChatBubble(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      clipper: ChatBubbleClipper5(
        // type: BubbleType.receiverBubble,
        type: type == ChatMessageType.sent
            ? BubbleType.sendBubble
            : BubbleType.receiverBubble,
      ),
      alignment:
          type == ChatMessageType.sent ? Alignment.topRight : Alignment.topLeft,
      margin: const EdgeInsets.only(top: 10),
      backGroundColor:
          type == ChatMessageType.sent ? Colors.blue : const Color(0xffE7E7ED),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: type == ChatMessageType.sent
                      ? Colors.white
                      : Colors.black),
            ),
            Text(
              DateFormat.Hm().format(DateTime.now()).toString(),
              style: const TextStyle(color: Color(0xff646060)),
            ),
          ],
        ),
      ),
    );
  }
}
