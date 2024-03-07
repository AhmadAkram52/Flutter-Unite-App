import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/chat/models/chat_model.dart';

class ConversationController extends GetxController {
  /* Variables */
  var chatList = Chat.generate().obs;

  /* Controllers */
  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /* Intents */
  Future<void> onFieldSubmitted() async {
    if (!isTextFieldEnable) return;

    // Add to chat listeners
    var newChat = Chat.sent(message: textEditingController.text);
    chatList.add(newChat);

    // Scroll to the bottom
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    textEditingController.clear();
    update(); // This is the GetX way to notify listeners
  }

  void onFieldChanged(String term) {
    update(); // Notify listeners whenever the field changes
  }

  /* Getters */
  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;
}
