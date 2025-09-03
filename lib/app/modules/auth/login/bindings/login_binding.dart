import 'package:get/get.dart';

import 'package:gas_dash/app/modules/auth/auth_controller/auth_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
