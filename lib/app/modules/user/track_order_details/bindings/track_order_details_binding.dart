import 'package:get/get.dart';

import '../controllers/track_order_details_controller.dart';

class TrackOrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackOrderDetailsController>(
      () => TrackOrderDetailsController(),
    );
  }
}
