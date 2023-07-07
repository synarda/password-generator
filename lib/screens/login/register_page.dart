import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:password_generator/controllers/register_controller.dart';

import '../../utils/utils.dart';
import '../../widgets/custom_textfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0), // here the desired height
          child: AppBar(
            backgroundColor: ColorsUtils.bacground,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "P",
                  style: TextStyle(color: ColorsUtils.neon, fontSize: 25),
                ),
                Text(
                  "GENERATE",
                  style: TextStyle(color: ColorsUtils.textColor, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: ColorsUtils.bacground,
        body: SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(children: [
              Positioned(
                left: -100,
                bottom: -80,
                child: SizedBox(
                  height: Get.height / 2,
                  child: Lottie.asset('lib/assets/95246-cloudbubbles-green.json'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorsUtils.bacground.withOpacity(0.7),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return false;
                      },
                      child: SingleChildScrollView(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: SizedBox(
                                  height: 130,
                                  width: Get.width,
                                  child: Lottie.asset('lib/assets/register01.json'),
                                ),
                              ),
                              CustomTextField(
                                obscure: false,
                                icon: const Icon(
                                  Icons.person,
                                  color: ColorsUtils.textColor,
                                ),
                                label: 'Name'.tr,
                                controller: controller.registerNameController,
                                limit: 50,
                              ),
                              CustomTextField(
                                type: TextInputType.emailAddress,
                                obscure: false,
                                icon: const Icon(
                                  Icons.email,
                                  color: ColorsUtils.textColor,
                                ),
                                label: 'Email'.tr,
                                controller: controller.registerEmailController,
                                limit: 50,
                              ),
                              Obx(() => CustomTextField(
                                    obscure: controller.confirmPassword.value ? false : true,
                                    icon: const Icon(
                                      Icons.lock,
                                      color: ColorsUtils.textColor,
                                    ),
                                    label: 'Password'.tr,
                                    controller: controller.registerPasswordController,
                                    limit: 50,
                                  )),
                              Obx(
                                () => CustomTextField(
                                  icon: IconButton(
                                      onPressed: () {
                                        if (controller.confirmPassword.value == false) {
                                          controller.confirmPassword.value = true;
                                        } else {
                                          controller.confirmPassword.value = false;
                                        }
                                      },
                                      icon: controller.confirmPassword.value
                                          ? const Icon(
                                              Icons.visibility_outlined,
                                              color: ColorsUtils.textColor,
                                            )
                                          : const Icon(
                                              Icons.visibility_off,
                                              color: ColorsUtils.textColor,
                                            )),
                                  label: "Confirm_password".tr,
                                  obscure: controller.confirmPassword.value ? false : true,
                                  controller: controller.registerPasswordCheckController,
                                  limit: 50,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 32, bottom: 16),
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    controller.checkPassword();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorsUtils.neon,
                                      textStyle: const TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.bold)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Register".tr,
                                        style: const TextStyle(color: ColorsUtils.foregroundBlack),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
