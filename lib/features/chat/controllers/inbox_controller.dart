import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/models/message_model.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

class InboxController extends GetxController {
  /* Variables */

  /* Controllers */
  final ScrollController scrollController = ScrollController();
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  RxString messageText = ''.obs;

  Future<void> onSentMessage({required String inboxId}) async {
    messageText.value = inputController.text.toString();
    if (messageText.value != '' && messageText.isNotEmpty) {
      await addTextMessage(messageText: messageText.value, inboxId: inboxId);
    }

    // Scroll to the bottom
    // scrollController.animateTo(
    //   scrollController.position.maxScrollExtent,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
    inputController.clear();
    update(); // This is the GetX way to notify listeners
  }

  Future<void> addTextMessage({
    required String messageText,
    required String inboxId,
  }) async {
    final String receiverId =
        await FireHelpers.chatsRef.doc(inboxId).get().then((value) {
      if (value.get('senderId') == FireHelpers.currentUserId) {
        return value.get('receiverId');
      } else {
        return value.get('senderId');
      }
    });
    final message = MessageModel(
        senderId: FireHelpers.currentUserId.toString(),
        receiverId: receiverId,
        messageTime: DateTime.now(),
        messageText: messageText.trimLeft());
    FireHelpers.chatsRef
        .doc(inboxId)
        .collection('messages')
        .add(message.toFireStore());
    FireHelpers.chatsRef
        .doc(inboxId)
        .update({'lastMessage': messageText.trimLeft()});
  }
}
