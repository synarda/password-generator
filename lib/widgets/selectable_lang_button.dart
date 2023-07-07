import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/utils/localization.dart';

import '../utils/utils.dart';

class SelectableLangButton extends StatelessWidget {
  const SelectableLangButton(
      {super.key,
      required this.idx,
      this.backColor = ColorsUtils.foregroundBlack,
      this.borderVisible = false,
      this.txtColor = ColorsUtils.textColor});
  final int idx;
  final bool borderVisible;
  final Color backColor;
  final Color txtColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: ColorsUtils.bacground.withOpacity(0.8),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ], color: backColor, borderRadius: BorderRadius.circular(20), border: borderVisible == true ? Border.all(color: ColorsUtils.neon) : null),
      child: Center(
        child: SizedBox(
          height: 45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                Localization().flags[idx],
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                Localization().langs[idx],
                style: TextStyle(fontSize: 10, color: txtColor),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
