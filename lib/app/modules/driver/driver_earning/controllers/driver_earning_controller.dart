
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_earning/model/single_driver_earning_model.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:get/get.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/widgets/custom_snackbar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';

class DriverEarningController extends GetxController {

  final amountController = TextEditingController();
  final cardHolderNameController = TextEditingController();
  final cardNumberController = TextEditingController();

  // Observable variables for reactive UI
  var todayEarnings = 0.0.obs;
  var totalEarnings = 0.0.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodayEarnings();
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    amountController.dispose();
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    super.onClose();
  }

  Future<void> fetchTodayEarnings() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String token = LocalStorage.getData(key: AppConstant.accessToken);

      var decodedToken = JwtDecoder.decode(token);

      var userId = decodedToken['userId']?.toString() ?? '';

      print(';;;;;;;;;;;;;;;; $userId ::::::::::');

      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await BaseClient.getRequest(
        api: Api.singleDriverEarning(userId),
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);

      final earningModel = SingleDriverEarningModel.fromJson(jsonResponse);

      if (earningModel.success == true && earningModel.data != null) {
        todayEarnings(earningModel.data!.todayEarnings ?? 0.0);
        totalEarnings(earningModel.data!.totalEarnings ?? 0.0);
      } else {
        errorMessage(earningModel.message ?? 'Failed to load earnings');
        kSnackBar(message: errorMessage.value, bgColor: AppColors.orange);
      }
    } catch (e) {
      errorMessage(e.toString());
      kSnackBar(message: errorMessage.value, bgColor: AppColors.orange);
    } finally {
      isLoading(false);
    }
  }


  // Function to handle withdraw request
  Future<void> submitWithdrawRequest() async {
    try {
      isLoading.value = true;

      // Get token from local storage
      String token = LocalStorage.getData(key: AppConstant.accessToken);

      // Prepare headers
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      // Prepare body
      final body = {
        'withdrawAmount': amountController.text.replaceAll('\$', '').trim(),
        // 'card_holder_name': cardHolderNameController.text.trim(),
        // 'card_number': cardNumberController.text.trim(),
      };

      // Make API call
      final response = await BaseClient.postRequest(
        api: Api.withdrawRequest,
        body: jsonEncode(body),
        headers: headers,
      );

      // Handle response
      final jsonResponse = await BaseClient.handleResponse(response);

      // Show success message
      kSnackBar(
        message: jsonResponse['message'] ?? 'Withdrawal request submitted successfully',
        bgColor: AppColors.green,
      );

      // Clear input fields
      amountController.clear();
      cardHolderNameController.clear();
      cardNumberController.clear();
    } catch (e) {
      // Show error message
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
