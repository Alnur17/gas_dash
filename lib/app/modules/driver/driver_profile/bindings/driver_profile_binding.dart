import 'package:get/get.dart';

import '../controllers/driver_profile_controller.dart';

class DriverProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverProfileController>(
      () => DriverProfileController(),
    );
  }
}
