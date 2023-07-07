import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/controllers/enddrawer_controller.dart';
import 'package:password_generator/controllers/home_controller.dart';
import 'package:password_generator/screens/save_password.dart';
import 'package:password_generator/screens/settings.dart';
import 'package:password_generator/utils/utils.dart';
import 'package:password_generator/widgets/checkbox.dart';
import 'package:password_generator/widgets/custom_strenght_txt.dart';
import 'package:password_generator/widgets/strenght_bar.dart';

import 'drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EndDrawerController());

    final controller = Get.put(Homecontroller());
    final controllerAuth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                splashColor: ColorsUtils.neon,
                icon: const Icon(
                  Icons.article_outlined,
                  color: ColorsUtils.textColor,
                  size: 25,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            Builder(
              builder: (context) {
                return GestureDetector(
                    onTap: Scaffold.of(context).openEndDrawer,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 16),
                      child: Center(
                        child: controllerAuth.user.value?.photoURL == null
                            ? CircleAvatar(
                                maxRadius: 13.0,
                                backgroundColor: ColorsUtils.textColor,
                                child: Center(
                                  child: Text(
                                    controllerAuth.user.value!.displayName.toString().substring(0, 1).toUpperCase(),
                                    style: const TextStyle(color: ColorsUtils.foregroundBlack, fontSize: 15),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                maxRadius: 15.0,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                    child: SizedBox(height: 80, child: Image.network(controllerAuth.user.value?.photoURL ?? ""))),
                              ),
                      ),
                    ));
              },
            )
          ],
          backgroundColor: ColorsUtils.foregroundBlack,
          title: Center(
            child: Text(
              "Password_Generator".tr,
              style: const TextStyle(color: ColorsUtils.textColor),
            ),
          )),
      drawer: const DrawerPage(),
      endDrawer: const Settings(),
      drawerScrimColor: Colors.black.withOpacity(0.8),
      backgroundColor: ColorsUtils.bacground,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                  child: Ink(
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorsUtils.foregroundBlack,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(() => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            controller.generatedPassword.value,
                            style: const TextStyle(color: ColorsUtils.textColor),
                          ),
                          IconButton(
                              onPressed: controller.generatedPassword.isEmpty
                                  ? null
                                  : () {
                                      Get.to(SavePasswordPage(generatedPassword: controller.generatedPassword.value));
                                    },
                              splashRadius: 24,
                              icon: Icon(
                                Icons.save,
                                color: controller.generatedPassword.isEmpty ? ColorsUtils.textColor.withOpacity(0.3) : ColorsUtils.textColor,
                              ))
                        ])),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorsUtils.foregroundBlack,
                  ),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Character_lenght".tr,
                                style: const TextStyle(
                                  color: ColorsUtils.textColor,
                                )),
                            Obx(
                              () => Text(
                                controller.charLength.value.toString(),
                                style: const TextStyle(color: ColorsUtils.neon, fontSize: 30),
                              ),
                            )
                          ],
                        ),
                        Obx(
                          () => Slider(
                            min: 6,
                            max: 18,
                            activeColor: ColorsUtils.neon,
                            thumbColor: const Color(0xffe4e3e8),
                            inactiveColor: ColorsUtils.bacground,
                            value: controller.charLength.value.toDouble(),
                            onChanged: (newrating) {
                              controller.charLength.value = newrating.toInt();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CheckboxPage(title: "Include_Uppercase_Letters", id: 0),
                        CheckboxPage(title: "Include_Lowercase_Letters", id: 1),
                        CheckboxPage(title: "Include_Numbers", id: 2),
                        CheckboxPage(title: "Include_Symbols", id: 3),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 14, bottom: 14, left: 16, right: 16),
                          decoration: BoxDecoration(color: ColorsUtils.bacground, borderRadius: BorderRadius.circular(10)),
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(
                              "Strenght".tr,
                              style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12),
                            ),
                            Obx(() => Row(
                                  children: [
                                    for (int i = 0; i < 1; i++)
                                      i < controller.strength ? CustomStrenghtText(txt: controller.strenghtTxt) : const CustomStrenghtText(),
                                    for (int i = 0; i < 6; i++)
                                      i < controller.strength ? StrenghtBar(color: controller.barColor) : const StrenghtBar()
                                  ],
                                )),
                          ]),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 50,
                          child: Obx(() => ElevatedButton(
                                onPressed: controller.generatorCharsetList.isEmpty
                                    ? null
                                    : () async {
                                        controller.generatePassword();
                                      },
                                style: ElevatedButton.styleFrom(
                                    disabledBackgroundColor: ColorsUtils.neon.withOpacity(0.4),
                                    backgroundColor: ColorsUtils.neon,
                                    // ignore: prefer_const_constructors
                                    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Generate".tr,
                                      style: const TextStyle(color: ColorsUtils.bacground),
                                    ),
                                    const Icon(
                                      Icons.arrow_right,
                                      color: ColorsUtils.bacground,
                                    )
                                  ],
                                ),
                              )),
                        )
                      ],
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
