// ignore_for_file: unused_local_variable
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_generator/controllers/global_bindings.dart';
import 'package:password_generator/firebase_options.dart';
import 'package:password_generator/screens/root.dart';
import 'package:password_generator/utils/localization.dart';

void main() async {
  await Hive.initFlutter();

  final configBox = await Hive.openBox<String>("config");
  final securityBox = await Hive.openBox<String>("security");
  final welcomeBox = await Hive.openBox<String>("welcome");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const Root(),
      locale: Localization().locale,
      fallbackLocale: Localization().fallbackLocale,
      translations: Localization(),
      initialBinding: GlobalBindings(),
      builder: (context, child) => FlutterEasyLoading(child: child),
    );
  }
}
