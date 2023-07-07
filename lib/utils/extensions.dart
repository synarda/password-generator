import 'package:get/get.dart';

extension StringX on String {
  String get categoryBeautifulName {
    final categoryParsed = split("|");
    final categoryIcon = categoryParsed.removeAt(0);
    final categoryName = categoryParsed.join("|");
    return "$categoryIcon ${categoryName.tr}";
  }

  String get categoryNameFirst {
    final categoryParsed = split("|");
    final categoryIcon = categoryParsed.first;
    return categoryIcon;
  }

  String get categoryNameLast {
    final categoryParsed = split("|");
    categoryParsed.removeAt(0);
    final categoryName = categoryParsed.join("|");
    return categoryName;
  }
}
