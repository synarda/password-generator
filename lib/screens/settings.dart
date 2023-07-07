import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/controllers/login_controller.dart';
import 'package:password_generator/screens/category_add.dart';
import 'package:password_generator/screens/change_language.dart';
import 'package:password_generator/widgets/custom_listile.dart';
import 'package:password_generator/widgets/custom_textbutton.dart';

import '../utils/utils.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerLogin = Get.put(LoginController());
    final controllerAuth = Get.find<AuthController>();

    return Drawer(
      backgroundColor: ColorsUtils.foregroundBlack,
      width: Get.width / 1.5,
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
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                color: ColorsUtils.bacground,
                height: 150,
                child: ListTile(
                  leading: SizedBox(
                    width: 64,
                    height: 64,
                    child: controllerAuth.user.value?.photoURL == null
                        ? CircleAvatar(
                            maxRadius: 40.0,
                            backgroundColor: ColorsUtils.textColor,
                            child: Center(
                              child: Text(
                                controllerAuth.user.value!.displayName.toString().substring(0, 1).toUpperCase(),
                                style: const TextStyle(color: ColorsUtils.foregroundBlack, fontSize: 15),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            maxRadius: 40.0,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                child: SizedBox(height: 80, child: Image.network(controllerAuth.user.value?.photoURL ?? ""))),
                          ),
                  ),
                  title: Text(
                    controllerAuth.user.value?.displayName ?? "",
                    style: const TextStyle(color: ColorsUtils.textColor, fontSize: 16),
                  ),
                  subtitle: Text(
                    controllerAuth.user.value?.email ?? "",
                    style: const TextStyle(color: ColorsUtils.textColor, fontSize: 10),
                  ),
                ),
              ),
              /*Container(
                color: ColorsUtils.bacground,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 12),
                      child: Center(
                        child: controllerAuth.user.value?.photoURL == null
                            ? CircleAvatar(
                                maxRadius: 30.0,
                                backgroundColor: ColorsUtils.textColor,
                                child: Center(
                                  child: Text(
                                    controllerAuth.user.value!.displayName.toString().substring(0, 1).toUpperCase(),
                                    style: const TextStyle(color: ColorsUtils.foregroundBlack, fontSize: 15),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                maxRadius: 30.0,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    child: SizedBox(height: 80, child: Image.network(controllerAuth.user.value?.photoURL ?? ""))),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controllerAuth.user.value?.displayName ?? "",
                      style: const TextStyle(color: ColorsUtils.textColor, fontSize: 16),
                    ),
                  ],
                ),
              ),*/
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  shrinkWrap: true,
                  children: [
                    CustomListile(
                      title: "CATEGORIES".tr,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.category,
                          color: ColorsUtils.textColor,
                          size: 17,
                        ),
                      ),
                      route: const CategoryAddPage(),
                    ),
                    CustomListile(
                      title: "Language".tr,
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.language,
                          color: ColorsUtils.textColor,
                          size: 17,
                        ),
                      ),
                      route: const ChangeLanguage(),
                    ),
                    GestureDetector(
                        onTap: () {
                          controllerAuth.resetPassword(controllerAuth.user.value!.email.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: ColorsUtils.bacground.withOpacity(0.8),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ], color: ColorsUtils.bacground, borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            title: Text(
                              "Password_Reset".tr,
                              style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12),
                            ),
                            leading: const Padding(
                              padding: EdgeInsets.only(left: 15, top: 12, bottom: 12, right: 8),
                              child: Icon(
                                Icons.key,
                                color: ColorsUtils.textColor,
                                size: 17,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              CustomTextButton(
                onTap: controllerLogin.signOut,
                label: "Sign_out".tr,
                color: ColorsUtils.foregroundBlack.withOpacity(0.8),
                labelcolor: ColorsUtils.neon.withOpacity(0.8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
