import 'dart:async';

import 'package:get/get.dart';
import 'package:password_generator/models/password.dart';
import 'package:password_generator/services/passoword_api.dart';
import 'package:share_plus/share_plus.dart';

class DrawerControllers extends GetxController {
  RxBool seePassword = false.obs;
  final selected = "".obs;

  String locedPassword(String pass) {
    final len = pass.length ~/ 4;
    final ilk = pass.substring(0, len);
    final ikinci = pass.substring(len * 4, pass.length);
    pass = ilk + ikinci.padLeft(pass.length - ilk.length, "*");
    return pass;
  }

  StreamSubscription<List<PasswordModel>>? getPasswordsHandle;

  final passwords = <PasswordModel>[].obs;

  @override
  void onInit() {
    print("girdi");
    fetch();
    super.onInit();
  }

  List<PasswordModel> filteredPasswords() {
    return passwords.where((pass) => selected.value == "" || pass.tagsUid == selected.value).toList();
  }

  void clear() {
    getPasswordsHandle?.cancel();
    passwords.clear();
  }

  void fetch() {
    getPasswordsHandle?.cancel();
    getPasswordsHandle = PasswordApi.getPasswords().listen((incomingPasswords) {
      passwords.value = incomingPasswords;
    });
  }

  void share(String pass) {
    Share.share(pass);
  }

  @override
  void onClose() {
    getPasswordsHandle?.cancel();
    super.onClose();
  }
}
