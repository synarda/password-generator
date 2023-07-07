// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/enddrawer_controller.dart';
import 'package:password_generator/screens/delete_alert.dart';
import 'package:password_generator/screens/edit_alert.dart';
import 'package:password_generator/screens/emoji_picker.dart';
import 'package:password_generator/utils/const.dart';
import 'package:password_generator/utils/utils.dart';
import 'package:password_generator/widgets/animated_listview.dart';
import 'package:password_generator/widgets/custom_textfield.dart';

class CategoryAddPage extends StatelessWidget {
  const CategoryAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EndDrawerController>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorsUtils.bacground,
        appBar: AppBar(
          backgroundColor: ColorsUtils.foregroundBlack,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add_Category".tr,
                style: const TextStyle(
                  color: ColorsUtils.textColor,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                  child: CustomTextField(
                    obscure: false,
                    controller: controller.addCategoryController,
                    label: "Category_Name".tr,
                    limit: 20,
                    icon: GestureDetector(
                        onTap: () => Get.dialog(EmojiPicker(
                              emojiList: Const.emojis,
                              initialIdx: controller.currentEmojiIdx.value,
                              onEmojiChanged: (emoji, index) => controller.currentEmojiIdx.value = index,
                            )),
                        child: Obx(() => SizedBox(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: Text(
                                Const.emojis[controller.currentEmojiIdx.value],
                                style: const TextStyle(fontSize: 20),
                              ),
                            )))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: controller.addCategory,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsUtils.neon, textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.add,
                            color: ColorsUtils.foregroundBlack,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add_Category".tr,
                            style: const TextStyle(color: ColorsUtils.foregroundBlack, fontSize: 12),
                          ),
                        ],
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      "CATEGORIES".tr,
                      style: const TextStyle(color: ColorsUtils.textColor),
                    )),
                const SizedBox(height: 8),
                Expanded(
                  child: Obx(() => AnimatedListView(
                        reverse: false,
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        children: controller.tags.map(
                          (tag) {
                            return Container(
                              key: ValueKey(tag.uid),
                              margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: ColorsUtils.bacground.withOpacity(0.8),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ], borderRadius: BorderRadius.circular(20), color: ColorsUtils.foregroundBlack),
                              child: ListTile(
                                  title: Text(
                                    tag.name.tr,
                                    style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12),
                                  ),
                                  leading: Text(
                                    tag.emoji,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  trailing: Ink(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: IconButton(
                                            splashRadius: 24,
                                            padding: const EdgeInsets.all(5),
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              Get.dialog(EditAlertPage(id: tag.uid, tagFullName: tag.emoji));
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: ColorsUtils.neon,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: IconButton(
                                            splashRadius: 24,
                                            padding: const EdgeInsets.all(5),
                                            constraints: const BoxConstraints(),
                                            onPressed: () async {
                                              Get.dialog(DeleteAlert(
                                                tagsId: tag.uid,
                                              ));
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: ColorsUtils.neon,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ).toList(),
                      )),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
