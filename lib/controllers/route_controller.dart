import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_generator/screens/welcome.dart';

import '../utils/const.dart';

class RouteController extends GetxController {
  LocalAuthentication auth = LocalAuthentication();

  final isAuthenticated = false.obs;
  final infoHeight = 100.0.obs;

  final showEmpty = true.obs;

  void animatedInfo() {
    if (infoHeight.value == 100.0) {
      infoHeight.value = 250.0;
    } else {
      infoHeight.value = 100.0;
    }
  }

  @override
  void onInit() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final welcomeBox = Hive.box<String>("welcome");

    if (welcomeBox.isNotEmpty) {
      showEmpty.value = false;

      await login();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    final welcomeBox = Hive.box<String>("welcome");
    if (welcomeBox.isEmpty) {
      await Get.to(const WelcomePage(
        Items: Const.welcomePageItems,
      ));
    }
    showEmpty.value = false;
    super.onReady();
  }

  Future<void> login() async {
    if (isAuthenticated.value) return;

    final authResult = await authenticate();
    isAuthenticated.value = authResult;
  }

  Future<bool> authenticate() async {
    final bool isBiometricsAvailable = await auth.isDeviceSupported();
    if (!isBiometricsAvailable) return false;

    try {
      return await auth.authenticate(
        localizedReason: 'Scan Fingerprint To Enter Vault',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
