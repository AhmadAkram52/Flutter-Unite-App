import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/controllers/conversation_controller.dart';
import 'package:unite/features/chat/models/user_model.dart';
import 'package:unite/features/chat/screens/conversation/widgets/bottom_input_field.dart';
import 'package:unite/utils/constants/enums.dart';

class ConversationScreen extends StatelessWidget {
  final UserModel user;

  const ConversationScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final ConversationController chatController =
        Get.put(ConversationController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.arrow_back_ios),
        // centerTitle: false,
        titleSpacing: -25,
        title: ListTile(
          leading: Stack(
            children: [
              Image.asset(
                user.image,
                height: 45,
              ),
              Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    height: 10,
                    width: 10,
                  ))
            ],
          ),
          title: Text(user.name),
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
                  child: Obx(() {
                    var chatList = chatController.chatList.reversed.toList();
                    return ListView.separated(
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.only(top: 12, bottom: 20) +
                          const EdgeInsets.symmetric(horizontal: 12),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 5,
                      ),
                      controller: chatController.scrollController,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return getBubbleView(
                          text:
                              "Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram, Ahmad Akram,",
                          context: context,
                          type: index % 2 == 0
                              ? ChatMessageType.received
                              : ChatMessageType.sent,
                        );
                      },
                    );
                  }),
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
  }) =>
      ChatBubble(
        clipper: ChatBubbleClipper5(
          // type: BubbleType.receiverBubble,
          type: type == ChatMessageType.sent
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble,
        ),
        alignment: type == ChatMessageType.sent
            ? Alignment.topRight
            : Alignment.topLeft,
        margin: const EdgeInsets.only(top: 20),
        backGroundColor: type == ChatMessageType.sent
            ? Colors.blue
            : const Color(0xffE7E7ED),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.7,
          ),
          child: Text(
            text,
            style: TextStyle(
                color:
                    type == ChatMessageType.sent ? Colors.white : Colors.black),
          ),
        ),
      );
}
