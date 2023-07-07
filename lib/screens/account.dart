import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/controllers/login_controller.dart';
import 'package:password_generator/utils/utils.dart';
import 'package:password_generator/widgets/custom_textbutton.dart';

class AccountPage extends GetView<AuthController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerLogin = Get.put(LoginController());
    return Scaffold(
      backgroundColor: ColorsUtils.bacground,
      appBar: AppBar(
        backgroundColor: ColorsUtils.foregroundBlack,
        centerTitle: true,
        title: Text(
          "account".tr,
          style: const TextStyle(
            color: ColorsUtils.textColor,
          ),
        ),
      ),
      body: Container(
        //color: ColorsUtils.bacground,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(color: ColorsUtils.foregroundBlack, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                      child: Align(
                        alignment: Alignment.center,
                        child: controller.user.value?.photoURL == null
                            ? const ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                child: Icon(
                                  Icons.person,
                                  size: 120,
                                ))
                            : ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                child: SizedBox(height: 80, child: Image.network(controller.user.value?.photoURL ?? ""))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.user.value?.displayName ?? "",
                          style: const TextStyle(color: ColorsUtils.textColor, fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Ink(
                  decoration: BoxDecoration(color: ColorsUtils.foregroundBlack, borderRadius: BorderRadius.circular(20)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          margin: const EdgeInsets.only(top: 18, left: 16, right: 16),
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorsUtils.bacground.withOpacity(0.8),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            color: ColorsUtils.bacground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Account_Name".tr,
                                style: const TextStyle(color: ColorsUtils.textColor, decoration: TextDecoration.underline, fontSize: 13),
                              ),
                              const Text(
                                ":",
                                style: TextStyle(
                                  color: ColorsUtils.textColor,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                Get.find<AuthController>().user.value?.displayName ?? "",
                                style: const TextStyle(
                                  color: ColorsUtils.textColor,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          margin: const EdgeInsets.only(top: 18, left: 16, right: 16),
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorsUtils.bacground.withOpacity(0.8),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            color: ColorsUtils.bacground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Account_Email".tr,
                                style: const TextStyle(color: ColorsUtils.textColor, decoration: TextDecoration.underline, fontSize: 13),
                              ),
                              const Text(
                                ":",
                                style: TextStyle(
                                  color: ColorsUtils.textColor,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                Get.find<AuthController>().user.value?.email ?? "",
                                style: const TextStyle(
                                  color: ColorsUtils.textColor,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width / 2,
                          child: CustomTextButton(
                            onTap: () => controller.resetPassword(controllerLogin.verifyEmailController.text),
                            label: "Password_Reset".tr,
                            color: ColorsUtils.foregroundBlack.withOpacity(0.8),
                            labelcolor: ColorsUtils.neon.withOpacity(0.8),
                          ),
                        ),
                        CustomTextButton(
                          onTap: controllerLogin.signOut,
                          label: "Sign_out".tr,
                          color: ColorsUtils.neon.withOpacity(0.8),
                          labelcolor: ColorsUtils.foregroundBlack,
                        ),
                      ],
                    )
                  ]),
                ),
              )),
        ]),
      ),
    );
  }
}
