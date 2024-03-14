import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InboxController extends GetxController {
  /* Variables */

  /* Controllers */
  final ScrollController scrollController = ScrollController();
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  RxString messageText = ''.obs;

  Future<void> onSentMessage({required String receiverId}) async {
    if (messageText.value != '' && messageText.isNotEmpty) {
      await addTextMessage(
          messageText: messageText.value, receiverId: receiverId);
    }

    // Scroll to the bottom
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    inputController.clear();
    update(); // This is the GetX way to notify listeners
  }

  Future<void> addTextMessage({
    required String messageText,
    required String receiverId,
  }) async {
    // print('Ahmad =>>>  $chatUsers');
    // FireHelpers.chatsRef.doc('id').set(
    //   chatUsers,
    // );
  }
}
