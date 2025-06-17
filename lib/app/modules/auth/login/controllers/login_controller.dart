import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/helper/socket_service.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../../driver/driver_dashboard/views/driver_dashboard_view.dart';
import '../../../user/dashboard/views/dashboard_view.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future userLogin({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);
      var map = {
        "email": email.toLowerCase(),
        "password": password,
      };

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: Api.login,
          body: jsonEncode(map),
          headers: headers,
        ),
      );

      if (responseBody != null) {
        String message = responseBody['message'].toString();
        bool success = responseBody['success'];

        if (success) {
          // Initialize SocketService
          await Get.putAsync(() => SocketService().init());
          String accessToken = responseBody['data']['accessToken'].toString();
          LocalStorage.saveData(
            key: AppConstant.accessToken,
            data: accessToken,
          );

          String userId = responseBody['data']['user']['_id'].toString();
          LocalStorage.saveData(
            key: AppConstant.userId,
            data: userId,
          );

          String refreshToken = responseBody['data']['refreshToken'].toString();
          LocalStorage.saveData(
            key: AppConstant.refreshToken,
            data: refreshToken,
          );

          String role =
              responseBody['data']['user']['role'].toString().toLowerCase();
          LocalStorage.saveData(key: AppConstant.role, data: role);
          kSnackBar(message: message, bgColor: AppColors.green);

          if (role == 'user') {
            Get.offAll(() => DashboardView());
          } else if (role == 'driver') {
            Get.offAll(() => DriverDashboardView());
          } else {
            kSnackBar(message: 'Unknown role', bgColor: AppColors.red);
          }
        } else {
          kSnackBar(message: 'Failed', bgColor: AppColors.red);
        }

        isLoading(false);
      } else {
        throw 'SignIn Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
