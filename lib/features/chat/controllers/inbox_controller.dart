import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/utils/helper/firebase_helper.dart';

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
    final chatUsers = <String, dynamic>{
      "user1Name":
          await fetchUserName(id: FireHelpers.fireAuth.currentUser!.uid),
      "user1Id": FireHelpers.fireAuth.currentUser!.uid,
      "user2Name": await fetchUserName(id: receiverId),
      "user2Id": receiverId,
      "lastMessage": messageText,
      "lastMessage": messageText,
    };
    // print('Ahmad =>>>  $chatUsers');
    FireHelpers.chatsRef.doc('id').set(
          chatUsers,
        );
  }

  Future<String> fetchUserName({required String id}) async {
    final user1 = await FireHelpers.fireStore.collection('Users').doc(id).get();
    String name = user1.get('name');
    return name;
  }
}
