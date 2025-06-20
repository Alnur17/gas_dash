import 'package:get/get.dart';

import 'package:gas_dash/app/modules/user/order_fuel/controllers/coupon_controller.dart';

import '../controllers/order_fuel_controller.dart';

class OrderFuelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CouponController>(
      () => CouponController(),
    );
    Get.lazyPut<OrderFuelController>(
      () => OrderFuelController(),
    );
  }
}
