import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../home/model/business_hour_model.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var isOutsideBusinessHours = true.obs;
  var businessHours = <Datum>[].obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      print('DashboardController: onInit called');
    }
    fetchBusinessHours();
    _timer = Timer.periodic(Duration(minutes: 1), (_) {
      if (kDebugMode) {
        print('DashboardController: Periodic timer triggered at ${DateTime.now()}');
      }
      checkBusinessHours();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    if (kDebugMode) {
      print('DashboardController: Timer cancelled onClose');
    }
    super.onClose();
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchBusinessHours() async {
    try {
      if (kDebugMode) {
        print('DashboardController: Fetching business hours from ${Api.businessHour}');
      }
      final response = await BaseClient.getRequest(
        api: Api.businessHour,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200) {
        if (kDebugMode) {
          print('DashboardController: API failed with status ${response.statusCode}');
        }
        isOutsideBusinessHours.value = true;
        return;
      }
      final jsonData = await BaseClient.handleResponse(response);
      final businessHourModel = BusinessHourModel.fromJson(jsonData);
      if (kDebugMode) {
        print('DashboardController: API response success: ${businessHourModel.success}');
        print('DashboardController: Data: ${businessHourModel.data.map((e) => {'day': e.day, 'time': e.time}).toList()}');
      }
      if (businessHourModel.success == true) {
        businessHours.assignAll(businessHourModel.data);
        if (kDebugMode) {
          print('DashboardController: Business hours loaded: ${businessHours.length} entries');
        }
        checkBusinessHours();
      } else {
        if (kDebugMode) {
          print('DashboardController: API success is false');
        }
        isOutsideBusinessHours.value = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('DashboardController: Error fetching business hours: $e');
      }
      isOutsideBusinessHours.value = true;
    }
  }

  void checkBusinessHours() {
    final now = DateTime.now();
    if (kDebugMode) {
      print('DashboardController: Checking business hours at ${DateFormat('hh:mm a').format(now)}');
    }

    // Use the first available time range, or default to 10:00 AM - 05:00 PM
    final effectiveHours = businessHours.isNotEmpty && businessHours.first.time != null
        ? businessHours.first
        : Datum(
      id: 'default',
      userType: 'default',
      v: 0,
      createdAt: DateTime.now(),
      day: 'default',
      time: '10:00 AM - 05:00 PM',
      updatedAt: DateTime.now(),
    );

    if (effectiveHours.time == null) {
      if (kDebugMode) {
        print('DashboardController: Invalid time');
      }
      isOutsideBusinessHours.value = true;
      return;
    }

    try {
      if (kDebugMode) {
        print('DashboardController: Parsing time: ${effectiveHours.time}');
      }
      final timeParts = effectiveHours.time!.split(' - ');
      if (timeParts.length != 2) {
        if (kDebugMode) {
          print('DashboardController: Invalid time format: ${effectiveHours.time}');
        }
        isOutsideBusinessHours.value = true;
        return;
      }

      final startTime = DateFormat('hh:mm a').parse(timeParts[0], true);
      final endTime = DateFormat('hh:mm a').parse(timeParts[1], true);
      if (kDebugMode) {
        print('DashboardController: Parsed startTime: ${timeParts[0]}, endTime: ${timeParts[1]}');
      }

      final startDateTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
      final endDateTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);
      if (kDebugMode) {
        print('DashboardController: Start: ${DateFormat('hh:mm a').format(startDateTime)}, End: ${DateFormat('hh:mm a').format(endDateTime)}');
      }

      final isOutside = now.isBefore(startDateTime) || now.isAfter(endDateTime);
      isOutsideBusinessHours.value = isOutside;
      if (kDebugMode) {
        print('DashboardController: isOutsideBusinessHours set to $isOutside (now: ${DateFormat('hh:mm a').format(now)})');
      }
    } catch (e) {
      if (kDebugMode) {
        print('DashboardController: Error parsing time: $e');
      }
      isOutsideBusinessHours.value = true;
    }
  }
}

extension StringExtension on String {
  bool equalsIgnoreCase(String other) => toLowerCase() == other.toLowerCase();
}