import 'package:get/get.dart';
import 'package:password_generator/controllers/auth_controller.dart';
import 'package:password_generator/controllers/global_controller.dart';
import 'package:password_generator/controllers/route_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(GlobalController());
    Get.put(RouteController());
  }
}
