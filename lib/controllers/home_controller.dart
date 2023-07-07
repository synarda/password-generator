import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/screens/login/sec_question_alert.dart';
import 'package:password_generator/utils/const.dart';
import 'package:password_generator/utils/to_encrypt.dart';
import 'package:password_generator/utils/utils.dart';

import '../utils/helper.dart';

class Homecontroller extends GetxController {
  final color1 = ColorsUtils.bacground;
  final color2 = ColorsUtils.textColor;

  final charLength = 6.obs;
  final generatorCharsetList = <int>{0, 1, 2, 3}.obs;
  var generatedPassword = "".obs;
  var myPassword = "".obs;

  int get strength {
    return generatorCharsetList.length + charLength.value ~/ 7;
  }

  @override
  void onReady() async {
    final box = Hive.box<String>("security");
    String? hash = box.get(Get.find<AuthController>().user.value?.uid);

    while (hash == null) {
      hash ??= await Get.dialog(const SecurityQuestionAlert(), barrierDismissible: false);
    }

    EncryptionAndDecryption().refreshKey(hash);
    super.onReady();
  }

  void generatePassword() {
    String charset = "";
    for (final cs in generatorCharsetList) {
      charset += Const.charsets[cs];
    }
    if (charset.isNotEmpty) {
      generatedPassword.value = Helper.generatePassword(charset, charLength.value);
      HapticFeedback.heavyImpact();
    }
  }

  String get strenghtTxt {
    return strength <= 2
        ? "Low"
        : strength <= 4
            ? "Medium"
            : "High";
  }

  Color get barColor {
    final str = strength;
    return str <= 2
        ? Colors.red
        : str <= 4
            ? Colors.yellow
            : Colors.green;
  }
}
