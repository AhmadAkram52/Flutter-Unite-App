import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unite/features/chat/controllers/inbox_controller.dart';
import 'package:unite/utils/constants/enums.dart';
import 'package:unite/utils/constants/text.dart';

class MessageBubbleView extends StatefulWidget {
  final BuildContext context;
  final String text;
  final UserType userType;
  final String messageType;
  final DateTime messageTime;

  const MessageBubbleView({
    super.key,
    required this.context,
    required this.text,
    required this.messageTime,
    required this.userType,
    required this.messageType,
  });

  @override
  State<MessageBubbleView> createState() => _MessageBubbleViewState();
}

class _MessageBubbleViewState extends State<MessageBubbleView> {
  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      clipper: ChatBubbleClipper5(
        // type: BubbleType.receiverBubble,
        type: widget.userType == UserType.sent
            ? BubbleType.sendBubble
            : BubbleType.receiverBubble,
      ),
      alignment: widget.userType == UserType.sent
          ? Alignment.topRight
          : Alignment.topLeft,
      margin: const EdgeInsets.only(top: 10),
      backGroundColor: widget.userType == UserType.sent
          ? Colors.blue
          : const Color(0xffE7E7ED),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (widget.messageType == UTexts.image)
              Image.network(widget.text)
            else if (widget.messageType == UTexts.video)
              VideoPlayerScreen(
                videoUrl: widget.text,
              )
            else
              Text(
                widget.text,
                style: TextStyle(
                    color: widget.userType == UserType.sent
                        ? Colors.white
                        : Colors.black),
              ),
            Text(
              DateFormat.Hm().format(widget.messageTime).toString(),
              style: const TextStyle(color: Color(0xff646060)),
            ),
          ],
        ),
      ),
    );
  }
}
