import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/home_controller.dart';
import 'package:password_generator/screens/lock_alert.dart';
import 'package:password_generator/services/passoword_api.dart';
import 'package:password_generator/utils/alerts.dart';
import 'package:password_generator/utils/to_encrypt.dart';

class SaveController extends GetxController {
  TextEditingController nameController = TextEditingController();
  late final TextEditingController passwordController;
  final passwordFilter = "".obs;
//

//

  final String generatedPassword;
  SaveController(this.generatedPassword);

  @override
  void onInit() {
    passwordController = TextEditingController(text: generatedPassword);

    super.onInit();
  }

  Future<void> savePassword(String passwordToBeSaved) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    try {
      final controllerHome = Get.find<Homecontroller>();
      final nameTxt = nameController.text.trim();

      if (nameTxt.isEmpty) {
        throw "Name_Null";
      }

      if (passwordFilter.value == "") {
        throw "Category_Null";
      }

      HapticFeedback.heavyImpact();
      final encryptedPassword = EncryptionAndDecryption().encryptAES(passwordToBeSaved);
      if (encryptedPassword == null) {
        throw "Answer_null";
      }
      final res = await PasswordApi.createPasswords(nameController.text, encryptedPassword, passwordFilter.value);
      if (res != null) {
        Get.dialog(const LockPage()).then((value) => Get.back());
        controllerHome.generatedPassword.value = "";
        controllerHome.generatorCharsetList.clear();
        controllerHome.generatorCharsetList.addAll({0, 1, 2, 3});
      }
      EasyLoading.dismiss();
    } catch (err) {
      Alerts.showAlert("error", err.toString().tr, 1500);
      HapticFeedback.mediumImpact();
    }
  }

  void chooseSaveStyle() async {
    if (passwordController.text.trim() == "") {
      Alerts.showAlert("error", "no_null".tr);
    } else {
      savePassword(passwordController.text.toString());
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
