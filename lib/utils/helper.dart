import 'dart:convert';
import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class Helper {
  static String generatePassword(String charset, int length) {
    final random = Random();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  static String categoryBeautifulName(String fullCategory) {
    final categoryParsed = fullCategory.split("|");
    final categoryIcon = categoryParsed.removeAt(0);
    final categoryName = categoryParsed.join("|");
    return "$categoryIcon $categoryName";
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
