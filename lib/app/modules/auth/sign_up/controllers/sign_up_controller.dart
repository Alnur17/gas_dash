import 'package:get/get.dart';

class SignUpController extends GetxController {
  var selectedRole = 'customer'.obs;

  // Handle radio button selection
  void selectRole(String role) {
    selectedRole.value = role;
  }
}
