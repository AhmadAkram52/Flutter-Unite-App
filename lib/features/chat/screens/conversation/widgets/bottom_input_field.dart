import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unite/features/chat/controllers/conversation_controller.dart';
import 'package:unite/utils/constants/colors.dart';

class BottomInputField extends StatelessWidget {
  const BottomInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final ConversationController chatController =
        Get.put(ConversationController());
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
                onChanged: chatController.onFieldChanged,
                controller: chatController.textEditingController,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  fillColor: UColors.inputFilledColor,
                  filled: true,
                  contentPadding: const EdgeInsets.only(
                    right: 42,
                    left: 16,
                    top: 18,
                  ),
                  hintText: 'message',
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
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: UColors.primary,
                  ),
                  color: UColors.white,
                  icon: const Icon(Iconsax.send_1),

                  // icon: SvgPicture.asset(
                  //   "assets/icons/send.svg",
                  //   colorFilter: ColorFilter.mode(
                  //     context.select<ChatController, bool>(
                  //             (value) => value.isTextFieldEnable)
                  //         ? const Color(0xFF007AFF)
                  //         : const Color(0xFFBDBDC2),
                  //     BlendMode.srcIn,
                  //   ),
                  // ),
                  onPressed: () => chatController.onFieldSubmitted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
