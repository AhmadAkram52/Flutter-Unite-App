import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unite/features/chat/controllers/inbox_controller.dart';
import 'package:unite/utils/constants/colors.dart';

class BottomInputField extends StatelessWidget {
  final String inboxId;

  const BottomInputField({super.key, required this.inboxId});

  @override
  Widget build(BuildContext context) {
    final InboxController inboxCtrl = Get.put(InboxController());
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
                focusNode: inboxCtrl.focusNode,
                onChanged: (text) {
                  inboxCtrl.messageText.value = text;
                },
                controller: inboxCtrl.inputController,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  fillColor: UColors.inputColor,
                  filled: true,
                  contentPadding: const EdgeInsets.only(
                    right: 80,
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
                  return (inboxCtrl.messageText.value.trimLeft().isEmpty)
                      ? IconButton(
                          icon: const Icon(Icons.image),
                          color: UColors.primary,
                          onPressed: () {
                            Get.bottomSheet(
                                SizedBox(
                                  height: 150,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Card(
                                        elevation: 5,
                                        shadowColor: UColors.primary,
                                        child: IconButton(
                                          icon: const Icon(Iconsax.gallery,
                                              size: 50),
                                          onPressed: () =>
                                              inboxCtrl.onSentImageFromGallery(
                                                  inboxId: inboxId),
                                        ),
                                      ),
                                      Card(
                                        elevation: 5,
                                        shadowColor: UColors.primary,
                                        child: IconButton(
                                          icon: const Icon(Iconsax.camera,
                                              size: 50),
                                          onPressed: () =>
                                              inboxCtrl.onSentImageFromCamera(
                                                  inboxId: inboxId),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.white);
                          },
                        )
                      : IconButton(
                          disabledColor: UColors.disable,
                          color: UColors.primary,
                          icon: const Icon(
                            Iconsax.send_21,
                            size: 32,
                          ),
                          onPressed: (inboxCtrl.messageText.value
                                  .trimLeft()
                                  .isEmpty)
                              ? null
                              : () {
                                  inboxCtrl.onSentTextMessage(inboxId: inboxId);
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
