import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/payment/views/payment_success_view.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../../payment/views/payment_view.dart';

class TripsController extends GetxController {
  var isLoading = false.obs;

  Future<void> createTrips({
    required String driverId,
    required String amount,
  }) async {
    isLoading.value = true;
    debugPrint(';;;;;;;;;;;;;;;;;; $driverId ;;;;;;;;;;;;;;;;;;;');
    String token = LocalStorage.getData(key: AppConstant.accessToken);

    // var decodedToken = JwtDecoder.decode(token);
    //
    // String? id = decodedToken['_id']?.toString();
    //String? id = profileAndSettingsController.myProfileData.value?.id ?? '';

    var headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    var map = {
      "driverId": driverId,
      "amount": amount
    };

    dynamic responseBody = await BaseClient.handleResponse(
      await BaseClient.postRequest(
        api: Api.optionalTipCreate,
        body: jsonEncode(map),
        headers: headers,
      ),
    );

    if (responseBody != null) {

     var tripId = await responseBody["data"]["_id"].toString();
     await tripPayment(tripId: tripId);

      isLoading.value = false;
    } else {
      Get.snackbar("Error", "Failed to create payment session");
    }
  }

  Future<void> tripPayment({
    required String tripId,

  }) async {
    isLoading.value = true;
    debugPrint(';;;;;;;;;;;;;;;;;; $tripId ;;;;;;;;;;;;;;;;;;;');
    String token = LocalStorage.getData(key: AppConstant.accessToken);

    var headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    var map = {
      "optionalTipId": tripId,

    };

    dynamic responseBody = await BaseClient.handleResponse(
      await BaseClient.postRequest(
        api: Api.optionalTipCheckout,
        body: jsonEncode(map),
        headers: headers,
      ),
    );

    if (responseBody != null) {

       Get.to(() => PaymentView(paymentUrl: responseBody["data"]));
      isLoading.value = false;
    } else {
      Get.snackbar("Error", "Failed to create payment session");
    }
  }
}
