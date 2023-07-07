import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/home_controller.dart';
import 'package:password_generator/utils/utils.dart';

class CheckboxPage extends GetView<Homecontroller> {
  const CheckboxPage({
    super.key,
    required this.id,
    required this.title,
  });
  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.generatorCharsetList.contains(id)) {
          controller.generatorCharsetList.remove(id);
        } else {
          controller.generatorCharsetList.add(id);
        }
      },
      child: Row(
        children: [
          SizedBox(
            height: 32,
            width: 32,
            child: Obx(
              () => Checkbox(
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                        width: 1.0, color: ColorsUtils.textColor),
                  ),
                  splashRadius: 16,
                  checkColor: ColorsUtils.bacground,
                  activeColor: ColorsUtils.neon,
                  value: controller.generatorCharsetList.contains(id),
                  onChanged: (value) {
                    if (value ?? false) {
                      controller.generatorCharsetList.add(id);
                    } else {
                      controller.generatorCharsetList.remove(id);
                    }
                  }),
            ),
          ),
          SizedBox(
            width: Get.width / 30,
          ),
          Text(
            title.tr,
            style: const TextStyle(color: ColorsUtils.textColor, fontSize: 14),
          )
        ],
      ),
    );
  }
}
