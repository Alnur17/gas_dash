import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderFuelController extends GetxController {
  final makes = ['Ford', 'Toyota', 'Honda'];
  final modelsByMake = {
    'Ford': ['F-150', 'Mustang', 'Explorer'],
    'Toyota': ['Corolla', 'Camry', 'RAV4'],
    'Honda': ['Civic', 'Accord', 'CR-V'],
  };
  final years = List.generate(30, (index) => (2025 - index).toString());

  var selectedMake = RxnString();
  var selectedModel = RxnString();
  var selectedYear = RxnString();
  var fuelLevelController = TextEditingController();

  var confirmedVehicle = Rxn<Map<String, String>>();

  void resetForm() {
    selectedMake.value = null;
    selectedModel.value = null;
    selectedYear.value = null;
    fuelLevelController.clear();
  }

  void confirmVehicle() {
    if (selectedMake.value == null ||
        selectedModel.value == null ||
        selectedYear.value == null ||
        fuelLevelController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    confirmedVehicle.value = {
      'Make': selectedMake.value!,
      'Model': selectedModel.value!,
      'Year': selectedYear.value!,
      'Fuel Level': fuelLevelController.text,
    };
    Get.back(); // Close dialog
  }
}
