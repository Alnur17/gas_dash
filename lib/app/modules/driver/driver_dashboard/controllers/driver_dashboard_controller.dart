import 'package:get/get.dart';

class DriverDashboardController extends GetxController {
  var selectedIndex = 0.obs; // Reactive variable to track selected tab

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
