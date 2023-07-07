import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/question_alert_controller.dart';
import 'package:password_generator/utils/const.dart';
import 'package:password_generator/utils/utils.dart';
import 'package:password_generator/widgets/custom_textfield.dart';

class SecurityQuestionAlert extends StatelessWidget {
  const SecurityQuestionAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionController());

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: AlertDialog(
          backgroundColor: ColorsUtils.foregroundBlack,
          title: Center(
            child: Text(
              "Security_Question".tr,
              style: const TextStyle(color: ColorsUtils.textColor),
            ),
          ),
          content: SizedBox(
            height: Get.height / 3.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(
                  () => DropdownButton<int>(
                      dropdownColor: ColorsUtils.foregroundBlack,
                      onChanged: (newValue) {
                        controller.setSelected(newValue ?? 0);
                      },
                      value: controller.selectedDrowpdownIdx.value,
                      items: [
                        for (int i = 0; i < Const.questions.length; i++)
                          DropdownMenuItem(
                            value: i,
                            child: Text(
                              Const.questions[i].tr,
                              style: const TextStyle(color: ColorsUtils.textColor, fontSize: 12),
                            ),
                          )
                      ]),
                ),
                CustomTextField(
                  label: "Answer".tr,
                  limit: 30,
                  obscure: false,
                  controller: controller.secQuestionAnswerController,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Dont_Forget".tr,
                          style: const TextStyle(color: Colors.red, fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 32, bottom: 16),
                  height: 30,
                  child: ElevatedButton(
                    onPressed: controller.saveSecurityAnswer,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsUtils.neon, textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save".tr,
                          style: const TextStyle(color: ColorsUtils.foregroundBlack),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
