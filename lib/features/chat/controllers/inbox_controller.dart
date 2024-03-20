import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unite/features/chat/models/message_model.dart';
import 'package:unite/utils/constants/text.dart';
import 'package:unite/utils/helper/firebase_helper.dart';
import 'package:video_player/video_player.dart';

class InboxController extends GetxController {
  /* Variables */

  /* Controllers */
  final ScrollController scrollController = ScrollController();
  final TextEditingController inputController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ImagePicker picker = ImagePicker();

  RxString messageText = ''.obs;

  Future<void> onSentTextMessage({required String inboxId}) async {
    messageText.value = inputController.text.toString();
    if (messageText.value != '' && messageText.isNotEmpty) {
      await addMessage(
          messageText: messageText.value,
          inboxId: inboxId,
          messageType: UTexts.text);
    }
    inputController.clear();
    messageText.value = '';
    update(); // This is the GetX way to notify listeners
  }

  Future<void> addMessage({
    required String messageText,
    required String messageType,
    required String inboxId,
  }) async {
    final String receiverId =
        await FireHelpers.chatsRef.doc(inboxId).get().then((value) {
      if (value.get(UTexts.senderId) == FireHelpers.currentUserId) {
        return value.get(UTexts.receiverId);
      } else {
        return value.get(UTexts.senderId);
      }
    });
    final message = MessageModel(
        senderId: FireHelpers.currentUserId.toString(),
        receiverId: receiverId,
        messageTime: DateTime.now(),
        messageText: messageText.trimLeft(),
        messageType: messageType);
    FireHelpers.chatsRef
        .doc(inboxId)
        .collection(UTexts.messages)
        .add(message.toFireStore());
    FireHelpers.chatsRef.doc(inboxId).update({
      UTexts.lastMessage: messageText.trimLeft(),
      UTexts.lastMessageType: messageType,
    });
  }

  onSentImageFromGallery({required String inboxId}) async {
    final XFile? image = await picker.pickMedia();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final String messageType;
    if (image != null) {
      Navigator.pop(Get.context!);
      File file = File(image.path);
      String fileType = file.path.split('.').last; // Get file extension
      String fileName =
          'ahmad/${DateTime.now().millisecondsSinceEpoch.toString()}_${Random().nextInt(10000)}.$fileType'; // Define an appropriate path and file name
      try {
        await FirebaseStorage.instance
            .ref(fileName)
            .putFile(file)
            .whenComplete(() async {
          final String imageUrl =
              await FirebaseStorage.instance.ref(fileName).getDownloadURL();
          await addMessage(
              messageText: imageUrl,
              inboxId: inboxId,
              messageType: getMessageType(fileType));
        });
        print('Upload successful');
      } catch (e) {
        print('Error occurred while uploading to Firebase Storage.');
      }
    } else {
      print('No image selected.');
    }
  }

  onSentImageFromCamera({required String inboxId}) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      Navigator.pop(Get.context!);
      File file = File(image.path);
      String fileName =
          'ahmad/${DateTime.now().millisecondsSinceEpoch.toString()}_${Random().nextInt(10000)}.jpg'; // Define an appropriate path and file name
      try {
        await FirebaseStorage.instance
            .ref(fileName)
            .putFile(file)
            .whenComplete(() async {
          final String imageUrl =
              await FirebaseStorage.instance.ref(fileName).getDownloadURL();
          await addMessage(
              messageText: imageUrl,
              inboxId: inboxId,
              messageType: UTexts.image);
        });
        print('Upload successful');
      } catch (e) {
        print('Error occurred while uploading to Firebase Storage.');
      }
    } else {
      print('No image selected.');
    }
  }

  String getMessageType(String extension) {
    if (extension == 'jpg') {
      return UTexts.image;
    } else if (extension == 'mp4') {
      return UTexts.video;
    } else {
      return extension;
    }
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
              IconButton(
                  style:
                      IconButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    controller.value.isPlaying
                        ? controller.pause()
                        : controller.play();
                    setState(() {});
                  },
                  icon: controller.value.isPlaying
                      ? const Icon(
                          Icons.pause,
                          size: 50,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          size: 50,
                        )),
            ],
          )
        : const CircularProgressIndicator();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
