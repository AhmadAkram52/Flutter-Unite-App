import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unite/utils/constants/enums.dart';

class MessageBubbleView extends StatelessWidget {
  final BuildContext context;
  final String text;
  final ChatMessageType type;
  final DateTime messageTime;

  const MessageBubbleView(
      {super.key,
      required this.context,
      required this.text,
      required this.messageTime,
      required this.type});

  @override
  Widget build(BuildContext context) {
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
              DateFormat.Hm().format(messageTime).toString(),
              style: const TextStyle(color: Color(0xff646060)),
            ),
          ],
        ),
      ),
    );
  }
}
