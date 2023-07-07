// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_generator/utils/utils.dart';
import 'package:password_generator/widgets/custom_dot.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key? key,
    required this.Items,
  }) : super(key: key);

  // ignore: non_constant_identifier_names
  final List<Map<String, dynamic>> Items;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late final AnimationController anim;
  late final AnimationController fadeAnimationController;
  final List<Widget> dot = [];
  Timer? opacityTimer;
  int index = 0;
  double opacity = 1.0;
  final welBox = Hive.box<String>("welcome");
  @override
  void initState() {
    for (var i = 0; i < widget.Items.length; i++) {
      dot.add(const CustomDot(
        color: ColorsUtils.textColor,
        dotHeight: 5,
      ));
    }

    fadeAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

    anim = AnimationController(duration: const Duration(seconds: 8), vsync: this)..repeat();
    anim.forward();
    fadeAnimationController.forward();
    opacityTimer = Timer(const Duration(seconds: 3), () {
      opacity = 0;
      setState(() {});
    });
    anim.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        goNext();
      }
    });
    super.initState();
  }

  void goBack() {
    if (index > 0) {
      setState(() {
        anim.forward(from: 0);
        fadeAnimationController.forward(from: 0);
        index -= 1;
      });
    }
  }

  void goNext() {
    index++;
    if (index >= widget.Items.length) {
      Get.back();
    } else {
      anim.forward(from: 0);
      fadeAnimationController.forward(from: 0);
      setState(() {});
    }
  }

  @override
  void dispose() {
    anim.dispose();
    opacityTimer?.cancel();
    fadeAnimationController.dispose();
    welBox.put("see", "see");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragStart: (e) => anim.stop(),
        onVerticalDragStart: (e) => anim.stop(),
        onTapDown: (e) => anim.stop(),
        onTapUp: (e) => anim.forward(),
        onVerticalDragEnd: (e) => anim.forward(),
        onHorizontalDragEnd: (details) {
          anim.forward();
          final velocity = details.primaryVelocity ?? 0;
          if (velocity > 0) {
            goBack();
          } else if (velocity < 0) {
            goNext();
          }
        },
        child: Scaffold(
            body: Container(
              color: ColorsUtils.bacground,
              child: Stack(
                children: [
                  SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: AnimatedBuilder(
                      animation: anim,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                            backgroundColor: ColorsUtils.bacground, color: ColorsUtils.foregroundBlack.withOpacity(0.3), value: anim.value);
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (index == dot.length - 1) {
                          Get.back();
                        } else {
                          goNext();
                        }
                      },
                      child: SizedBox(
                        height: Get.height,
                        width: Get.width / 8,
                        child: Center(
                          child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(200.0), bottomRight: Radius.circular(200.0)),
                              ),
                              height: Get.height,
                              width: Get.width / 8,
                              child: Center(
                                  child: Container(
                                      padding: const EdgeInsets.only(top: 24, bottom: 24, left: 20, right: 4),
                                      decoration: BoxDecoration(
                                        color: ColorsUtils.foregroundBlack.withOpacity(0.2),
                                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(200.0), topLeft: Radius.circular(200.0)),
                                      ),
                                      child: Icon(
                                        Icons.arrow_right,
                                        color: ColorsUtils.textColor.withOpacity(0.2),
                                      )))),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedBuilder(
                          animation: fadeAnimationController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: fadeAnimationController.value,
                              child: Center(
                                  child: Column(
                                children: [
                                  const SizedBox(height: 100),
                                  Container(
                                    height: 250,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorsUtils.bacground.withOpacity(0.8),
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.asset(widget.Items[index]["photographPath"]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 64.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 32, right: 32),
                                      child: Text(
                                        widget.Items[index]["title"].toString().tr,
                                        style: const TextStyle(color: ColorsUtils.neon, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0, right: 64),
                                    child: Text(
                                      widget.Items[index]["description"].toString().tr,
                                      style: const TextStyle(fontSize: 12, color: ColorsUtils.textColor),
                                    ),
                                  ),
                                ],
                              )),
                            );
                          }),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: goBack,
                      child: SizedBox(
                        height: Get.height,
                        width: Get.width / 8,
                        child: Center(
                          child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(200.0), bottomRight: Radius.circular(200.0)),
                              ),
                              height: Get.height,
                              width: Get.width / 8,
                              child: Center(
                                  child: Container(
                                      padding: const EdgeInsets.only(top: 24, bottom: 24, right: 16, left: 4),
                                      decoration: BoxDecoration(
                                        color: ColorsUtils.foregroundBlack.withOpacity(0.2),
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(200.0), bottomRight: Radius.circular(200.0)),
                                      ),
                                      child: Icon(
                                        Icons.arrow_left,
                                        color: ColorsUtils.textColor.withOpacity(0.2),
                                      )))),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 27),
                      height: 15,
                      width: 80,
                      child: Row(children: [
                        for (int i = 0; i < dot.length; i++)
                          CustomDot(
                            color: i - 1 < index ? ColorsUtils.neon : ColorsUtils.textColor,
                            dotHeight: i == index
                                ? 12
                                : i - 1 < index
                                    ? 5
                                    : 5,
                          )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: index == dot.length - 1
                ? FloatingActionButton.extended(
                    heroTag: "welcome_next",
                    backgroundColor: ColorsUtils.foregroundBlack,
                    onPressed: () {
                      if (index == dot.length - 1) {
                        Get.back();
                      } else {
                        goNext();
                      }
                    },
                    label: Row(children: [
                      index == dot.length - 1
                          ? Text("go".tr, style: const TextStyle(color: ColorsUtils.neon, fontSize: 12))
                          : Text("next".tr, style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12)),
                      Icon(
                        Icons.arrow_right,
                        color: index == dot.length - 1 ? ColorsUtils.neon : ColorsUtils.textColor,
                      ),
                    ]),
                  )
                : Container()));
  }
}
