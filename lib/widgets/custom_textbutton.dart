import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/utils/utils.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.onTap,
      required this.label,
      required this.color,
      this.labelcolor = ColorsUtils.foregroundBlack});
  final String label;
  final Function()? onTap;
  final Color color;
  final Color labelcolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: Get.width,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ColorsUtils.neon.withOpacity(0.2))),
          child: Text(
            label,
            style: TextStyle(color: labelcolor, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
