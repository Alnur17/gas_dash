import 'package:get/get.dart';

class DriverHistoryController extends GetxController {

  var isOnTheWay = false.obs; // State to track if delivery is marked as "On the Way"

  void markAsOnTheWay() {
    isOnTheWay.value = true; // Update state when button is clicked
  }
}
