import 'package:get/get.dart';
import 'package:unite/features/chat/models/inbox_model.dart';
import 'package:unite/features/chat/screens/inbox/inbox_screen.dart';
import 'package:unite/utils/constants/text.dart';
import 'package:unite/utils/helper/firebase_helper.dart';
import 'package:unite/utils/helper/helper_funtions.dart';

class ChatController extends GetxController {
  createChat(user) async {
    final inbox = InboxModel(
        inboxId: UHelpers.sortString(
            '${user[UTexts.uid]}${FireHelpers.currentUserId}'),
        senderName: await UHelpers.fetchUserName(
            id: FireHelpers.currentUserId.toString()),
        senderId: FireHelpers.fireAuth.currentUser!.uid,
        receiverName: await UHelpers.fetchUserName(id: user[UTexts.uid]),
        receiverId: user[UTexts.uid],
        lastMessage: '',
        messageCounter: 0,
        lastMessageType: '');
    FireHelpers.chatsRef
        .doc(UHelpers.sortString(
            '${user[UTexts.uid]}${FireHelpers.currentUserId}'))
        .set(inbox.toJson());
    Get.to(InboxScreen(
      inboxId: UHelpers.sortString(
          '${user[UTexts.uid]}${FireHelpers.currentUserId}'),
    ));
  }
}
