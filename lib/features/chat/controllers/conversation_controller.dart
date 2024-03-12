import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

class ConversationController extends GetxController {
  /* Variables */

  /* Controllers */
  final ScrollController scrollController = ScrollController();
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  RxString messageText = ''.obs;

  Future<void> onSentMessage() async {
    if (messageText.value != '' && messageText.isNotEmpty) {
      await FirebaseHelpers.addTextMessage(
          messageText: messageText.value, receiverId: "12");
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
}
