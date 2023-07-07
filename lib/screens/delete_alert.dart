import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_generator/services/passoword_api.dart';
import 'package:password_generator/services/tag_api.dart';
import 'package:password_generator/utils/alerts.dart';

import '../utils/utils.dart';

class DeleteAlert extends StatelessWidget {
  const DeleteAlert({
    super.key,
    this.passId = "",
    this.tagsId = "",
  });

  final String passId;
  final String tagsId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsUtils.foregroundBlack,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: Center(
        child: Text(
          "Are_U_Sure?".tr,
          style: const TextStyle(color: ColorsUtils.neon),
        ),
      ),
      content: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          height: 40,
          width: 100,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsUtils.neon,
              ),
              onPressed: () => Get.back(),
              child: Text(
                "Back".tr,
                style: const TextStyle(
                    color: ColorsUtils.foregroundBlack, fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(
          height: 40,
          width: 100,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                if (passId.isEmpty) {
                  TagApi.hasPasswords(tagsId).then((value) {
                    if (value == true) {
                      Alerts.showAlert("error", "Saved_Error".tr, 1500);
                    } else {
                      TagApi.deleteTag(tagsId);
                    }
                  });
                } else if (tagsId.isEmpty) {
                  PasswordApi.deletePassword(passId);
                }
                HapticFeedback.mediumImpact();
                Get.back();
              },
              child: Text(
                "Delete".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ]),
    );
  }
}
