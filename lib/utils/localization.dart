import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/lang/de_de.dart';
import 'package:password_generator/lang/en_us.dart';
import 'package:password_generator/lang/ep_ep.dart';
import 'package:password_generator/lang/fr_f.dart';
import 'package:password_generator/lang/kr_kr.dart';
import 'package:password_generator/lang/tr_tr.dart';

class Localization extends Translations {
  static final Localization _instance = Localization._internal();

  factory Localization() {
    return _instance;
  }

  Localization._internal();
  Locale locale = const Locale('en', 'US');
  String currentLang = "English";
  final fallbackLocale = const Locale('en', 'US');

  final langs = [
    'English',
    'Türkçe',
    'español',
    'Deutsch',
    'Français',
    '한국인',
  ];

  final flags = ['🇬🇧', '🇹🇷', "🇪🇸", "🇩🇪", "🇫🇷", "🇰🇷"];

  // Supported locales
  // Needs to be same order with langs
  final locales = const [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
    Locale('ep', 'EP'),
    Locale('de', 'DE'),
    Locale('fr', 'FR'),
    Locale('kr', 'KR'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'tr_TR': trTR,
        'ep_EP': epEP,
        'de_DE': deDE,
        'fr_F': frF,
        'kr_kr': krKR,
      };

  // Gets locale from language, and updates the locale
  Future<Locale> changeLocale(String lang) async {
    final tempLocale = _getLocaleFromLanguage(lang);
    await Get.updateLocale(tempLocale);
    locale = tempLocale;
    currentLang = lang;
    return locale;
  }

  // Finds language in `langs` list and returns it as Locale
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale!;
  }
}
