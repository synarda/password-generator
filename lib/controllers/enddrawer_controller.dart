import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_generator/models/tags.dart';
import 'package:password_generator/services/tag_api.dart';
import 'package:password_generator/utils/alerts.dart';
import 'package:password_generator/utils/const.dart';

class EndDrawerController extends GetxController {
  TextEditingController addCategoryController = TextEditingController();
  final currentEmojiIdx = 1.obs;
  final istheme = false.obs;

  StreamSubscription<List<TagsModel>>? getTagsHandle;
  final tags = <TagsModel>[].obs;

  @override
  void onInit() {
    fetch();
    super.onInit();
  }

  @override
  void onClose() {
    getTagsHandle?.cancel();
    addCategoryController.dispose();
    super.onClose();
  }

  void addCategory() {
    final txt = addCategoryController.text.trim();
    if (txt.isEmpty) {
      Alerts.showAlert("Success", "Category_Null".tr, 1500);
      HapticFeedback.mediumImpact();
    } else {
      TagApi.createTag(txt, Const.emojis[currentEmojiIdx.value]);
      addCategoryController.clear();
      currentEmojiIdx.value = 1;
    }
  }

  void clear() {
    getTagsHandle?.cancel();
    tags.clear();
  }

  void fetch() {
    getTagsHandle?.cancel();
    getTagsHandle = TagApi.getTags().listen((incomingTags) {
      tags.value = incomingTags;
      if (tags.isEmpty) {
        TagApi.createTag("Games", "🎮");
        TagApi.createTag("Work", "👨‍💻");
        TagApi.createTag("Social Media", "📱");
      }
    });
  }
}
