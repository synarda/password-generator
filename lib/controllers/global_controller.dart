import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_generator/utils/localization.dart';

class GlobalController extends GetxController {
  final currentLanguage = "English".obs;

  void getSavedLanguage() {
    final configBox = Hive.box<String>("config");

    final lang = configBox.get("language");

    final deviceLocaleName = Platform.localeName.split("_").first;

    int deviceLocaleIdx = Localization()
        .locales
        .indexWhere((e) => e.languageCode == deviceLocaleName);

    if (deviceLocaleIdx == -1) deviceLocaleIdx = 0;

    final language = lang ?? Localization().langs[deviceLocaleIdx];

    Localization().changeLocale(language);
    currentLanguage.value = language;
  }

  @override
  void onInit() {
    getSavedLanguage();
    super.onInit();
  }

  changeLanguage(String language) async {
    await Localization().changeLocale(language);
    final configBox = Hive.box<String>("config");
    await configBox.put("language", language);
    currentLanguage.value = language;
    HapticFeedback.heavyImpact();
  }
}
