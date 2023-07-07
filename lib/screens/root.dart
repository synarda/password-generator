import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/controllers/route_controller.dart';
import 'package:password_generator/screens/home_page.dart';
import 'package:password_generator/screens/login/login_page.dart';
import 'package:password_generator/screens/route_page.dart';

class Root extends GetView<RouteController> {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.showEmpty.value
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
          )
        : controller.isAuthenticated.value
            ? Get.find<AuthController>().user.value == null
                ? const LoginPage()
                : const HomePage()
            : const RoutePage());
  }
}
