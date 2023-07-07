import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:password_generator/utils/extensions.dart';

class EditAlertController extends GetxController {
  TextEditingController editController = TextEditingController();
  final currentEmoji = "".obs;

  final String tagFullName;
  EditAlertController({required this.tagFullName});

  @override
  void onInit() {
    currentEmoji.value = tagFullName.categoryNameFirst;
    editController.text = tagFullName.categoryNameLast;
    super.onInit();
  }

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }
}
