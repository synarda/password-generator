import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_generator/controllers/auth_controller.dart';

class LoginController extends GetxController {
//Login controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
//Verify controllers
  final TextEditingController verifyEmailController = TextEditingController();

  Future<void> signInAndSave() async {
    Get.find<AuthController>().signIn(
      "emailSignIn",
      email: emailController.text,
      password: passwordController.text,
    );

    await Hive.box<String>("config").put("SaveLastEmail", emailController.text);
    passwordController.clear();
  }

  @override
  void onInit() {
    emailController.text = Hive.box<String>("config").get("SaveLastEmail") ?? "";
    super.onInit();
  }

  void signOut() {
    passwordController.text = "";
    emailController.text = Hive.box<String>("config").get("SaveLastEmail") ?? "";
    Get.find<AuthController>().signOut();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    verifyEmailController.dispose();
    super.onClose();
  }
}
