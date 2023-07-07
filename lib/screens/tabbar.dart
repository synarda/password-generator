// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/drawer_controller.dart';
import 'package:password_generator/controllers/enddrawer_controller.dart';

import '../utils/utils.dart';

class Tabbar extends StatelessWidget {
  const Tabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DrawerControllers>();
    final controllerEndDrawer = Get.find<EndDrawerController>();
    return SizedBox(
        height: 80,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Saved_Password".tr,
                  style: const TextStyle(
                    color: ColorsUtils.neon,
                  ),
                ),
                Obx(() => IconButton(
                    padding: const EdgeInsets.all(5),
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      if (controller.seePassword.value == false) {
                        controller.seePassword.value = true;
                      } else {
                        controller.seePassword.value = false;
                      }
                    },
                    icon: controller.seePassword.value == false
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: ColorsUtils.textColor,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: ColorsUtils.textColor,
                            size: 20,
                          ))),
              ],
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: ColorsUtils.foregroundBlack,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Obx(
                () => DefaultTabController(
                    length: controllerEndDrawer.tags.length + 1,
                    child: TabBar(
                      onTap: ((value) {
                        final tagsList = controllerEndDrawer.tags.asMap();
                        if (value == 0) {
                          controller.selected.value = "";
                        } else {
                          controller.selected.value = tagsList[value - 1]!.uid;
                        }
                      }),
                      indicatorColor: ColorsUtils.neon,
                      isScrollable: true,
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("All".tr, style: const TextStyle(fontSize: 13, color: ColorsUtils.textColor)),
                        ),
                        ...controllerEndDrawer.tags.map((element) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(element.emoji),
                                  const SizedBox(width: 5),
                                  Text(element.name.tr, style: const TextStyle(fontSize: 13, color: ColorsUtils.textColor)),
                                ],
                              ),
                            )),
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
