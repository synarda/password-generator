import 'package:flutter_easyloading/flutter_easyloading.dart';

class Alerts {
  static Future<void> showAlert(String title, String message, [int duration = 1500]) async {
    EasyLoading.showToast(
      message,
      duration: Duration(milliseconds: duration),
    );
  }
}
