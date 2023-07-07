import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/controllers/login_controller.dart';
import 'package:password_generator/utils/alerts.dart';

import '../../utils/utils.dart';
import '../../widgets/custom_textfield.dart';

class ForgotPage extends GetView<AuthController> {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerLogin = Get.find<LoginController>();

    return WillPopScope(
      onWillPop: () async {
        controllerLogin.verifyEmailController.clear();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsUtils.bacground,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "P",
                  style: TextStyle(color: ColorsUtils.neon, fontSize: 35),
                ),
                Text(
                  "GENERATE",
                  style: TextStyle(color: ColorsUtils.textColor, fontSize: 20),
                ),
              ],
            ),
          ),
          backgroundColor: ColorsUtils.bacground,
          body: SafeArea(
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  Positioned(
                    left: -100,
                    bottom: -80,
                    child: SizedBox(
                      height: Get.height / 2,
                      child: Lottie.asset('lib/assets/95246-cloudbubbles-green.json'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 24, right: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorsUtils.bacground.withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowIndicator();
                          return false;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height / 4,
                                      width: Get.width,
                                      child: Lottie.asset('lib/assets/verify.json'),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    CustomTextField(
                                      type: TextInputType.emailAddress,
                                      obscure: false,
                                      icon: const Icon(
                                        Icons.email,
                                        color: ColorsUtils.textColor,
                                      ),
                                      label: 'Email'.tr,
                                      controller: controllerLogin.verifyEmailController,
                                      limit: 50,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 32, bottom: 24),
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (controllerLogin.verifyEmailController.text.isEmpty) {
                                            Alerts.showAlert("error", "no_null".tr);
                                          } else {
                                            controller
                                                .resetPassword(
                                                    controllerLogin.verifyEmailController.text)
                                                .then((value) {
                                              Get.back();
                                              controllerLogin.verifyEmailController.clear();
                                              Alerts.showAlert("Success", "Send_Email".tr, 1500);
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorsUtils.neon,
                                            textStyle: const TextStyle(
                                                fontSize: 15, fontWeight: FontWeight.bold)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Send_email".tr,
                                              style: const TextStyle(color: ColorsUtils.bacground),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
