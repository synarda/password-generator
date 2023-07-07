import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/controllers/login_controller.dart';

import '../../utils/utils.dart';
import '../../widgets/custom_textfield.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorsUtils.bacground,
        body: Stack(
          children: [
            Positioned(
              left: -100,
              bottom: -60,
              child: SizedBox(
                height: Get.height / 2,
                child: Lottie.asset("lib/assets/95246-cloudbubbles-green.json"),
              ),
            ),
            Center(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return false;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorsUtils.bacground.withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  type: TextInputType.emailAddress,
                                  obscure: false,
                                  icon: const Icon(
                                    Icons.email,
                                    color: ColorsUtils.textColor,
                                  ),
                                  label: 'Email'.tr,
                                  limit: 50,
                                  controller: loginController.emailController,
                                ),
                                CustomTextField(
                                  obscure: true,
                                  icon: const Icon(
                                    Icons.lock,
                                    color: ColorsUtils.textColor,
                                  ),
                                  label: 'Password'.tr,
                                  limit: 50,
                                  controller: loginController.passwordController,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: ColorsUtils.neon,
                                      ),
                                      child: Text(
                                        "Forgot_Password".tr,
                                        style:
                                            const TextStyle(color: ColorsUtils.neon, fontSize: 11),
                                      ),
                                      onPressed: () => Get.to(const ForgotPage()),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        loginController.signInAndSave();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorsUtils.neon,
                                          textStyle: const TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Login".tr,
                                            style:
                                                const TextStyle(color: ColorsUtils.foregroundBlack),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              Row(children: <Widget>[
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                                      child: const Divider(
                                        color: ColorsUtils.textColor,
                                        height: 90,
                                      )),
                                ),
                                Text(
                                  "or".tr,
                                  style: const TextStyle(color: ColorsUtils.textColor),
                                ),
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                                      child: const Divider(
                                        color: ColorsUtils.textColor,
                                        height: 90,
                                      )),
                                ),
                              ]),
                              Column(children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        controller.signIn("google");
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          textStyle: const TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("lib/assets/google_icon.png"),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "With_Google".tr,
                                              style: const TextStyle(
                                                  color: ColorsUtils.foregroundBlack,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Platform.isAndroid
                                    ? const SizedBox()
                                    : Container(
                                        padding: const EdgeInsets.all(8),
                                        child: SizedBox(
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              controller.signIn("apple");
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                textStyle: const TextStyle(
                                                    fontSize: 15, fontWeight: FontWeight.bold)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset("lib/assets/apple_icon.png"),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "With_Apple".tr,
                                                    style: const TextStyle(
                                                        color: ColorsUtils.foregroundBlack,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Dont_have_account".tr,
                                      style: const TextStyle(
                                          color: ColorsUtils.textColor, fontSize: 12),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: ColorsUtils.neon,
                                      ),
                                      child: Text("Signup_here".tr),
                                      onPressed: () => Get.to(const RegisterPage()),
                                    )
                                  ],
                                ),
                              ])
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
