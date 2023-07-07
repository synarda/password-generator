import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_generator/controllers/auth_controller.dart';

import '../utils/alerts.dart';

class RegisterController extends GetxController {
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerPasswordCheckController = TextEditingController();
  final confirmPassword = false.obs;

  Future<void> lastEmailSave() async {
    final configBox = Hive.box<String>("config");
    await configBox.put("SaveLastEmail", registerEmailController.text);
  }

// TODO : buradan devamedeceksin
  Future<void> checkPassword() async {
    if (registerPasswordController.text == registerPasswordCheckController.text &&
        registerEmailController.text.isNotEmpty &&
        registerNameController.text.isNotEmpty &&
        registerPasswordController.text.isNotEmpty) {
      Get.back();

      await AuthController().signUpWithEmail(registerEmailController.text,
          registerPasswordController.text, registerNameController.text);
      await lastEmailSave();
      EasyLoading.dismiss();
    } else {
      Alerts.showAlert("Success", "Pass_not_same".tr, 1500);
      confirmPassword.value = true;
    }
  }

  @override
  void onClose() {
    registerEmailController.dispose();
    registerNameController.dispose();
    registerPasswordController.dispose();
    registerPasswordCheckController.dispose();
    super.onClose();
  }
}
