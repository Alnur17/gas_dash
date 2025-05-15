import 'package:get/get.dart';

import 'package:gas_dash/app/modules/driver/driver_history/controllers/driver_completion_checklist_controller.dart';

import '../controllers/driver_history_controller.dart';

class DriverHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverCompletionChecklistController>(
      () => DriverCompletionChecklistController(),
    );
    Get.lazyPut<DriverHistoryController>(
      () => DriverHistoryController(),
    );
  }
}
