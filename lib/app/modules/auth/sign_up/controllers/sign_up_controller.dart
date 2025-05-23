import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/sign_up/views/sign_up_otp_verify_view.dart';
import 'package:get/get.dart';

import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../../driver/driver_dashboard/views/driver_dashboard_view.dart';
import '../../../user/dashboard/views/dashboard_view.dart';

class SignUpController extends GetxController {
  var selectedRole = 'user'.obs;
  var isLoading = false.obs;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  final countryController = TextEditingController();
  final zipCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final driverFullNameController = TextEditingController();
  final driverEmailController = TextEditingController();
  final driverPasswordController = TextEditingController();
  final driverConfirmPasswordController = TextEditingController();

  void selectRole(String role) {
    selectedRole.value = role;
  }

  Future<void> registerUser() async {
    try {
      isLoading(true);

      Map<String, dynamic> body;
      if (selectedRole.value == 'user') {
        if (passwordController.text.trim() !=
            confirmPasswordController.text.trim()) {
          Get.snackbar('Error', 'Passwords do not match');
          return;
        }

        body = {
          "role": "user",
          "fullname": fullNameController.text.trim(),
          "email": emailController.text.trim(),
          "location": locationController.text.trim(),
          "country": countryController.text.trim(),
          "zipCode": zipCodeController.text.trim(),
          "password": passwordController.text.trim(),
        };
      } else {
        if (driverPasswordController.text.trim() !=
            driverConfirmPasswordController.text.trim()) {
          Get.snackbar('Error', 'Passwords do not match');
          return;
        }

        body = {
          "role": "driver",
          "fullname": driverFullNameController.text.trim(),
          "email": driverEmailController.text.trim(),
          "password": driverPasswordController.text.trim(),
        };
      }

      final response = await BaseClient.postRequest(
        api: Api.register,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );

      final data = await BaseClient.handleResponse(response);

      print('Response data: $data');

      if (data != null) {
        final otpToken = data['data']?['otpToken']?['token'];
        if (otpToken != null && otpToken.toString().isNotEmpty) {
          await LocalStorage.saveData(
              key: AppConstant.otpToken, data: otpToken.toString());
          String getOtp = LocalStorage.getData(key: AppConstant.otpToken);

          print('::::::::::: $getOtp ::::::::::::::::::');
          final String email = selectedRole.value == 'user'
              ? emailController.text.trim()
              : driverEmailController.text.trim();

          Get.to(() => SignUpOtpVerifyView(email: email));
        } else {
          Get.snackbar('Error', 'OTP token is missing in response.');
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtp({required String otp}) async {
    try {
      isLoading(true);

      String token = await LocalStorage.getData(key: AppConstant.otpToken);
      print('Using token for OTP verify: $token');

      final body = {
        "otp": otp,
      };

      final response = await BaseClient.postRequest(
        api: Api.otpVerify,
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "token": token,
        },
      );

      final data = await BaseClient.handleResponse(response);

      print('OTP verification response data: $data');

      if (data != null) {
        final authToken = data['data']?['token'];
        if (authToken != null && authToken.toString().isNotEmpty) {
          Get.snackbar("Success", "OTP Verified Successfully.");

          if (selectedRole.value == "user") {
            Get.offAll(() => DashboardView());
          } else if (selectedRole.value == "driver") {
            Get.offAll(() => DriverDashboardView());
          } else {
            Get.snackbar("Error", 'Something wrong with user role');
          }
        } else {
          Get.snackbar('Error', 'Auth token is missing in response.');
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}

