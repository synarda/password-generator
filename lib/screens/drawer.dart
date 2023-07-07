import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:password_generator/controllers/enddrawer_controller.dart';
import 'package:password_generator/screens/save_password.dart';
import 'package:password_generator/screens/tabbar.dart';
import 'package:password_generator/utils/utils.dart';
import 'package:password_generator/widgets/animated_listview.dart';
import 'package:password_generator/widgets/list_widget.dart';

import '../controllers/drawer_controller.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  late final DrawerControllers controller;

  @override
  void initState() {
    controller = Get.put(DrawerControllers());
    super.initState();
  }

  @override
  void dispose() {
    controller.selected.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerEndDrawer = Get.find<EndDrawerController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Drawer(
          backgroundColor: ColorsUtils.bacground,
          width: Get.width,
          child: Stack(
            children: [
              Positioned(
                left: -100,
                bottom: -100,
                child: SizedBox(
                  height: Get.height / 2,
                  child: Lottie.asset("lib/assets/95246-cloudbubbles-green.json"),
                ),
              ),
              Column(children: [
                Container(color: ColorsUtils.bacground, height: 150, child: const Tabbar()),
                Expanded(
                  child: Obx(() {
                    final filteredPasswords = controller.filteredPasswords();
                    return filteredPasswords.isNotEmpty
                        ? AnimatedListView(
                            key: ValueKey(controller.selected.value),
                            reverse: false,
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            children: filteredPasswords
                                .map((pass) => ListWidget(
                                      key: ValueKey(pass.uid),
                                      emoji: controllerEndDrawer.tags.firstWhere((e) => e.uid == pass.tagsUid).emoji,
                                      password: pass,
                                    ))
                                .toList(),
                          )
                        : Center(
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ], borderRadius: BorderRadius.circular(20), color: ColorsUtils.foregroundBlack),
                                child: Text(
                                  "not_save_pass".tr,
                                  style: const TextStyle(fontSize: 10, color: ColorsUtils.textColor),
                                )),
                          );
                  }),
                )
              ]),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: ColorsUtils.foregroundBlack,
            onPressed: () {
              Get.to(const SavePasswordPage());
            },
            label: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: ColorsUtils.textColor,
                ),
                const SizedBox(width: 8),
                Text(
                  "add_your_password".tr,
                  style: const TextStyle(color: ColorsUtils.textColor, fontSize: 10),
                ),
              ],
            )),
      ),
    );
  }
}
