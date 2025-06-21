import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/emergency_fuel/controllers/schedule_delivery_from_calender_controller.dart';
import 'package:gas_dash/app/modules/user/order_fuel/controllers/order_fuel_controller.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../order_fuel/views/fuel_type_final_confirmation_view.dart';

class ScheduleDeliveryFromCalenderView extends GetView {
  final bool isEmergency;
  final String vehicleId;
  final bool presetAmount;
  final bool customAmount;
  final double amount;
  final String fuelType;

  final ScheduleDeliveryFromCalenderController
      scheduleDeliveryFromCalenderController =
      Get.put(ScheduleDeliveryFromCalenderController());
  final OrderFuelController orderFuelController =
      Get.put(OrderFuelController());

  ScheduleDeliveryFromCalenderView({
    super.key,
    required this.isEmergency,
    required this.vehicleId,
    required this.customAmount,
    required this.presetAmount,
    required this.amount,
    required this.fuelType,
  });

  String getFormattedTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  String getMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    return Scaffold(
      backgroundColor: Color(0xFFF4F9FC),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with back and title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ],
                        ),
                        child: Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Schedule Delivery',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Image
                ClipRRect(
                  borderRadius: borderRadius,
                  child: Image.asset(
                    AppImages.deliveryManImage, // Replace with your image
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  'Select Date:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 8),

                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: scheduleDeliveryFromCalenderController
                            .goToPreviousMonth,
                      ),
                      Text(
                        getMonthYear(scheduleDeliveryFromCalenderController
                                .focusedDay.value)
                            .toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: scheduleDeliveryFromCalenderController
                            .goToNextMonth,
                      ),
                    ],
                  );
                }),

                // Calendar
                Obx(() {
                  return TableCalendar(
                    firstDay: DateTime.utc(2010, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay:
                        scheduleDeliveryFromCalenderController.focusedDay.value,
                    selectedDayPredicate: (day) => isSameDay(
                        scheduleDeliveryFromCalenderController
                            .selectedDay.value,
                        day),
                    onDaySelected:
                        scheduleDeliveryFromCalenderController.onDaySelected,
                    calendarStyle: CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Color(0xFFD7EDF9),
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        shape: BoxShape.circle,
                      ),
                      defaultDecoration: BoxDecoration(
                        color: Color(0xFFF2F7FA),
                        shape: BoxShape.circle,
                      ),
                      weekendDecoration: BoxDecoration(
                        color: Color(0xFFF2F7FA),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.black),
                      defaultTextStyle: TextStyle(color: Colors.black87),
                      weekendTextStyle: TextStyle(color: Colors.black87),
                      todayTextStyle: TextStyle(color: Colors.black),
                    ),
                    headerVisible: false,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.black54),
                      weekendStyle: TextStyle(color: Colors.black54),
                    ),
                  );
                }),

                SizedBox(height: 16),

                Text(
                  'Select Time',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 8),

                Obx(() {
                  return GestureDetector(
                    onTap: () => scheduleDeliveryFromCalenderController
                        .pickTime(context),
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadius,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            scheduleDeliveryFromCalenderController
                                        .selectedTime.value !=
                                    null
                                ? getFormattedTime(
                                    scheduleDeliveryFromCalenderController
                                        .selectedTime.value)
                                : '3:00 PM',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Icon(Icons.access_time, color: Colors.grey.shade700),
                        ],
                      ),
                    ),
                  );
                }),

                SizedBox(height: 12),

                Text(
                  'Delivery scheduled',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 4),

                Obx(() {
                  final dateStr = DateFormat('MMMM d, yyyy').format(
                      scheduleDeliveryFromCalenderController.selectedDay.value);
                  final timeStr = getFormattedTime(
                      scheduleDeliveryFromCalenderController
                          .selectedTime.value);
                  return Text(
                    'Delivery scheduled for $dateStr at $timeStr.',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  );
                }),

                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.mainColor,
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: CustomButton(
          text: 'Next',
          onPressed: () {
            print(
                'Date: ${scheduleDeliveryFromCalenderController.selectedDay.value}');
            print(
                'Time: ${scheduleDeliveryFromCalenderController.selectedTime.value.format(context)}');
            Get.to(
              () => FuelTypeFinalConfirmationView(
                isEmergency: isEmergency,
                vehicleId: vehicleId,
                presetAmount: presetAmount,
                fuelType: fuelType,
                amount: amount,
                customAmount: customAmount,
                scheduleDate:
                    "${scheduleDeliveryFromCalenderController.selectedDay.value}",
                scheduleTime: scheduleDeliveryFromCalenderController
                    .selectedTime.value
                    .format(context),
              ),
            );
            // orderFuelController.createOrder(
            //   isEmergency: isEmergency,
            //   vehicleId: orderFuelController.selectedVehicle.value?.id ?? '',
            //   presetAmount: orderFuelController.presetEnabled.value,
            //   customAmount: orderFuelController.customEnabled.value,
            //   amount: amount,
            //   fuelType: fuelType,
            //   schedulDate:
            //       "${scheduleDeliveryFromCalenderController.selectedDay.value}",
            //   schedulTime: scheduleDeliveryFromCalenderController
            //       .selectedTime.value
            //       .format(context),
            // );
          },
          gradientColors: AppColors.gradientColorGreen,
        ),
      ),
    );
  }
}
