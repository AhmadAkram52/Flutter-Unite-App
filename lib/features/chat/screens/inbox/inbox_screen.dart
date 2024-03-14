import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unite/features/chat/controllers/inbox_controller.dart';
import 'package:unite/features/chat/models/message_model.dart';
import 'package:unite/features/chat/screens/inbox/widgets/bottom_input_field.dart';
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
            builder: (_, s) {
              if (s.data?.get('senderId') == FireHelpers.currentUserId) {
                return Text(s.data?.get('receiverName'));
              } else {
                return Text(s.data?.get('senderName'));
              }
            },
          ),
          subtitle: const Text("Last Active: "),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () async {
              final message = MessageModel(
                  senderId: FireHelpers.currentUserId.toString(),
                  receiverId: "receiverId",
                  messageTime: DateTime.now(),
                  messageText: "Ahmad Akram");
              FireHelpers.chatsRef
                  .doc(inboxId)
                  .collection('messages')
                  .add(message.toFireStore());
              // chatController.addTextMessage(messageText: 'ad', receiverId: '');
              // chatController.fetchUserName(id: user['uid']);
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
            const BottomInputField(
                // user: user,
                ),
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
