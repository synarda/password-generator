import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/edit_alert_controller.dart';
import 'package:password_generator/screens/emoji_picker.dart';
import 'package:password_generator/services/tag_api.dart';
import 'package:password_generator/utils/const.dart';
import 'package:password_generator/widgets/custom_textfield.dart';

import '../utils/alerts.dart';
import '../utils/utils.dart';

class EditAlertPage extends StatelessWidget {
  const EditAlertPage({super.key, required this.id, required this.tagFullName});

  final String id;
  final String tagFullName;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditAlertController(tagFullName: tagFullName));

    return AlertDialog(
      backgroundColor: ColorsUtils.foregroundBlack,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: Center(
        child: Row(
          children: [
            Text(
              "Edit_Name".tr,
              style: const TextStyle(color: ColorsUtils.neon),
            ),
          ],
        ),
      ),
      content: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomTextField(
              obscure: false,
              icon: GestureDetector(
                  onTap: () => Get.dialog(EmojiPicker(
                        emojiList: Const.emojis,
                        initialIdx: Const.emojis.indexOf(controller.currentEmoji.value),
                        onEmojiChanged: (emoji, index) => controller.currentEmoji.value = emoji,
                      )),
                  child: Obx(() => SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: Text(
                            controller.currentEmoji.value,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ))),
              controller: controller.editController,
              label: "New_Name".tr,
              limit: 20,
            ),
            SizedBox(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.editController.text.trim().isEmpty) {
                    HapticFeedback.mediumImpact();
                    Alerts.showAlert("Success", "Name_Null".tr, 1500);
                  } else {
                    HapticFeedback.heavyImpact();
                    await TagApi.editTag(
                        id, controller.editController.text, controller.currentEmoji.value);
                    Get.back();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsUtils.neon,
                    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit".tr,
                      style: const TextStyle(color: ColorsUtils.bacground, fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
