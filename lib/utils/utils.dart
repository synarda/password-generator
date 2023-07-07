import 'package:flutter/material.dart';

class ColorsUtils {
  static const bacground = Color(0xff100f15);
  static const textColor = Color(0xffafaeb6);
  static const foregroundBlack = Color(0xff24232b);
  static const neon = Color(0xffa4ffaf);
  static const bar = Color(0xfff6cd66);
  //light mode

  final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.blue,
      buttonTheme: const ButtonThemeData(
        buttonColor: neon,
        disabledColor: neon,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red));

  final ThemeData lightTheme = ThemeData(
      primaryColor: Colors.red,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        disabledColor: Colors.grey,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink));
}
