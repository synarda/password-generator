import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/global_controller.dart';
import 'package:password_generator/utils/localization.dart';
import 'package:password_generator/widgets/selectable_lang_button.dart';
import 'package:password_generator/widgets/shimmer.dart';

import '../utils/utils.dart';

class ChangeLanguage extends GetView<GlobalController> {
  const ChangeLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsUtils.bacground,
        appBar: AppBar(
          backgroundColor: ColorsUtils.foregroundBlack,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose_Language".tr,
                style: const TextStyle(
                  color: ColorsUtils.textColor,
                ),
              ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: Localization().langs.length,
                    itemBuilder: ((context, index) {
                      final lang = Localization().langs[index];
                      return Obx(() => GestureDetector(
                          onTap: () => controller.changeLanguage(lang),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ShimmerWrapper(
                              radius: 15,
                              active: controller.currentLanguage.value == lang,
                              child: controller.currentLanguage.value == lang
                                  ? SelectableLangButton(
                                      borderVisible: true,
                                      idx: index,
                                      backColor: ColorsUtils.foregroundBlack.withOpacity(0.2),
                                      txtColor: ColorsUtils.neon,
                                    )
                                  : SelectableLangButton(
                                      idx: index,
                                      txtColor: ColorsUtils.textColor,
                                    ),
                            ),
                          )));
                    }),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
