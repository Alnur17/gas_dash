import 'package:get/get.dart';

class DriverCompletionChecklistController extends GetxController {
  var option1Selected = false.obs;
  var option2Selected = false.obs;

  void selectOption1() {
    option1Selected.value = true;
    option2Selected.value = false;
  }

  void selectOption2() {
    option1Selected.value = false;
    option2Selected.value = true;
  }
}
