import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/route_controller.dart';
import 'package:password_generator/utils/utils.dart';

class RoutePage extends GetView<RouteController> {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Text(
                "P",
                style: TextStyle(color: ColorsUtils.neon, fontSize: 35),
              ),
              Text(
                "GENERATE",
                style: TextStyle(color: ColorsUtils.textColor, fontSize: 20),
              ),
            ]),
          ),
          backgroundColor: ColorsUtils.foregroundBlack,
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        color: ColorsUtils.bacground,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              GestureDetector(
                onTap: controller.login,
                child: Container(
                    margin: const EdgeInsets.only(top: 30, left: 8, right: 8),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: ColorsUtils.textColor.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ], borderRadius: BorderRadius.circular(20), color: ColorsUtils.foregroundBlack),
                    width: Get.width / 2.7,
                    height: Get.height / 4,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4, top: 16, bottom: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.fingerprint,
                              size: 32,
                              color: ColorsUtils.neon,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Finger_Print".tr,
                              style: TextStyle(color: ColorsUtils.textColor, fontSize: Get.height / 60),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: AppSettings.openSecuritySettings,
                child: Container(
                    margin: const EdgeInsets.only(top: 30, left: 8, right: 8),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: ColorsUtils.textColor.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ], borderRadius: BorderRadius.circular(20), color: ColorsUtils.foregroundBlack),
                    width: Get.width / 2.7,
                    height: Get.height / 4,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.gpp_good_rounded,
                              color: ColorsUtils.neon,
                              size: 32,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Create_pass_phone".tr,
                              style: TextStyle(color: ColorsUtils.textColor, fontSize: Get.height / 60),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ]),
            Obx(
              () => SizedBox(
                height: Get.height / 2.9,
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: controller.animatedInfo,
                    child: AnimatedContainer(
                        curve: Curves.easeInBack,
                        duration: const Duration(milliseconds: 500),
                        margin: const EdgeInsets.only(top: 4, left: 16, right: 16),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: ColorsUtils.textColor.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ], borderRadius: BorderRadius.circular(20), color: ColorsUtils.foregroundBlack),
                        width: Get.width,
                        height: controller.infoHeight.value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5, top: 32, bottom: 16),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.info,
                                    color: ColorsUtils.neon,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Column(
                                    children: [
                                      Text(
                                        "Info".tr,
                                        style: const TextStyle(color: ColorsUtils.textColor, fontSize: 18),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color: ColorsUtils.textColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 32),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.fingerprint,
                                            color: ColorsUtils.neon,
                                          ),
                                          const SizedBox(width: 12),
                                          SizedBox(
                                            width: Get.width / 1.8,
                                            child: Text("Scan_txt".tr, style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.gpp_good_rounded, color: ColorsUtils.neon),
                                          const SizedBox(width: 12),
                                          SizedBox(
                                            width: Get.width / 1.8,
                                            child: Text("Create_txt".tr, style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
