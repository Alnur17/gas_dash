import 'package:get/get.dart';

import '../controllers/order_fuel_controller.dart';

class OrderFuelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderFuelController>(
      () => OrderFuelController(),
    );
  }
}
