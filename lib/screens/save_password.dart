import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/enddrawer_controller.dart';
import 'package:password_generator/controllers/save_controller.dart';
import 'package:password_generator/widgets/animated_listview.dart';
import 'package:password_generator/widgets/custom_textfield.dart';
import 'package:password_generator/widgets/radio_button.dart';

import '../utils/utils.dart';

class SavePasswordPage extends StatelessWidget {
  const SavePasswordPage({super.key, this.generatedPassword = ""});
  final String generatedPassword;
  @override
  Widget build(BuildContext context) {
    final controllerEndDrawer = Get.find<EndDrawerController>();

    final controller = Get.put(SaveController(generatedPassword));

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
                "Save_Password".tr,
                style: const TextStyle(
                  color: ColorsUtils.textColor,
                ),
              ),
            ],
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 32),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.transparent),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: controller.passwordController,
                      obscure: false,
                      label: "Password".tr,
                      limit: 30,
                      focus: false,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      obscure: false,
                      controller: controller.nameController,
                      label: "Password_Name".tr,
                      limit: 30,
                      focus: false,
                    ),
                  ],
                ),
              )),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: ColorsUtils.foregroundBlack),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                      child: Text(
                        "CATEGORIES".tr,
                        style: const TextStyle(fontSize: 10, color: ColorsUtils.textColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(() => AnimatedListView(
                          reverse: false,
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          children: controllerEndDrawer.tags
                              .map(
                                (tags) => GestureDetector(
                                  key: ValueKey(tags.uid),
                                  onTap: () {
                                    controller.passwordFilter.value = tags.uid;
                                  },
                                  child: RadioButton(
                                    id: tags.uid,
                                    title: tags.name,
                                    emoji: tags.emoji,
                                  ),
                                ),
                              )
                              .toList(),
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 40,
            width: Get.width / 2,
            child: ElevatedButton(
              onPressed: () {
                controller.chooseSaveStyle();
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: ColorsUtils.neon, textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Save".tr,
                    style: const TextStyle(color: ColorsUtils.bacground, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
