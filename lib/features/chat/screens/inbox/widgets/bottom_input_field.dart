import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unite/features/chat/controllers/inbox_controller.dart';
import 'package:unite/utils/constants/colors.dart';

class BottomInputField extends StatelessWidget {
  // final QueryDocumentSnapshot user;

  const BottomInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final InboxController chatController = Get.put(InboxController());
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E5EA),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              TextField(
                focusNode: chatController.focusNode,
                onChanged: (text) {
                  chatController.messageText.value = text;
                },
                controller: chatController.inputController,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  fillColor: UColors.inputColor,
                  filled: true,
                  contentPadding: const EdgeInsets.only(
                    right: 42,
                    left: 16,
                    top: 18,
                  ),
                  hintText: 'message here.....',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              // custom suffix btn
              Positioned(
                bottom: 0,
                right: 0,
                child: Obx(() {
                  return IconButton(
                      disabledColor: UColors.disable,
                      color: UColors.primary,
                      icon: const Icon(
                        Iconsax.send_21,
                        size: 32,
                      ),
                      onPressed: chatController.messageText.value == ""
                          ? null
                          : () {
                              chatController.inputController.clear();
                              // chatController.onSentMessage(
                              //     receiverId: user['uid']);
                            });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
