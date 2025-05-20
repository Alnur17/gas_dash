import 'package:get/get.dart';

import 'package:gas_dash/app/modules/user/emergency_fuel/controllers/schedule_delivery_from_calender_controller.dart';

import '../controllers/emergency_fuel_controller.dart';

class EmergencyFuelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleDeliveryFromCalenderController>(
      () => ScheduleDeliveryFromCalenderController(),
    );
    Get.lazyPut<EmergencyFuelController>(
      () => EmergencyFuelController(),
    );
  }
}
