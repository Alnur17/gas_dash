import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleDeliveryFromCalenderController extends GetxController {

  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  var selectedTime = TimeOfDay(hour: 15, minute: 0).obs;

  void onDaySelected(DateTime day, DateTime focusedDayValue) {
    selectedDay.value = day;
    focusedDay.value = focusedDayValue;
  }

  void goToPreviousMonth() {
    focusedDay.value = DateTime(focusedDay.value.year, focusedDay.value.month - 1, 1);
  }

  void goToNextMonth() {
    focusedDay.value = DateTime(focusedDay.value.year, focusedDay.value.month + 1, 1);
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

}
