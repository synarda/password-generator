import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/utils/utils.dart';

class CustomStrenghtText extends StatelessWidget {
  const CustomStrenghtText({super.key, this.txt = "Low"});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Text(
      txt.tr,
      style: const TextStyle(color: ColorsUtils.textColor, fontSize: 10),
    );
  }
}
