import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/services/questions_api.dart';
import 'package:password_generator/utils/alerts.dart';
import 'package:password_generator/utils/const.dart';
import 'package:password_generator/utils/to_encrypt.dart';

class QuestionController extends GetxController {
  TextEditingController secQuestionAnswerController = TextEditingController();
  final selectedDrowpdownIdx = 0.obs;
  late Question question;

  @override
  void onInit() async {
    question = await QuestionsApi.getQuestion();
    selectedDrowpdownIdx.value = question.index == -1 ? 0 : question.index;
    super.onInit();
  }

  void setSelected(int idx) {
    selectedDrowpdownIdx.value = idx;
  }

  void saveSecurityAnswer() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    final answerTxt = secQuestionAnswerController.text.trim();
    try {
      if (answerTxt.length < 3) {
        throw "answer_must_be_at_last_3";
      }
      final controllerAuth = Get.find<AuthController>();
      final securityBox = Hive.box<String>("security");

      final jsonEncode = json.encode(answerTxt);

      final hash = sha1.convert(utf8.encode(jsonEncode)).toString().substring(0, 32);
      EncryptionAndDecryption().refreshKey(hash);

      if (question.index != -1) {
        late final bool answerIsCorrect;

        try {
          answerIsCorrect = EncryptionAndDecryption().decryptAES(question.text) == Const.defaultQuestion;
        } catch (_) {
          answerIsCorrect = false;
        }

        if (!answerIsCorrect) {
          throw "unknown";
        }
      }

      final text = EncryptionAndDecryption().encryptAES(Const.defaultQuestion);
      if (text == null) {
        throw "answer_not_correct";
      }

      await securityBox.put(controllerAuth.user.value!.uid, hash);
      await QuestionsApi.createQuestion(selectedDrowpdownIdx.value, text);
      Get.back(result: hash);
    } catch (err) {
      Alerts.showAlert("error", err.toString().tr);
    }

    EasyLoading.dismiss();
  }

  @override
  void onClose() {
    secQuestionAnswerController.dispose();
    super.onClose();
  }
}
