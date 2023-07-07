import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/save_controller.dart';
import 'package:password_generator/utils/utils.dart';

class RadioButton extends GetView<SaveController> {
  const RadioButton({
    super.key,
    required this.id,
    required this.title,
    required this.emoji,
  });
  final String id;
  final String title;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: Get.width,
        margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: controller.passwordFilter.value == id ? ColorsUtils.neon.withOpacity(0.2) : ColorsUtils.bacground,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ], borderRadius: BorderRadius.circular(20), color: ColorsUtils.bacground),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: Theme(
                data: ThemeData.dark(),
                child: Radio(
                  activeColor: ColorsUtils.neon,
                  value: controller.passwordFilter.value == id,
                  onChanged: (value) {
                    controller.passwordFilter.value = id;
                  },
                  groupValue: true,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(emoji),
            const SizedBox(width: 8),
            Text(
              title.tr,
              style: const TextStyle(color: ColorsUtils.textColor, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
