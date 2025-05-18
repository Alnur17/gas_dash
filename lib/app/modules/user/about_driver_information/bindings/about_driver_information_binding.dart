import 'package:get/get.dart';

import '../controllers/about_driver_information_controller.dart';

class AboutDriverInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutDriverInformationController>(
      () => AboutDriverInformationController(),
    );
  }
}
