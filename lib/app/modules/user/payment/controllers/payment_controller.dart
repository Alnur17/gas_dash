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
import '../views/payment_view.dart';

class PaymentController extends GetxController {

  var isLoading = false.obs;

  Future<void> createPaymentSession({
    required String orderId,
  })
  async {
    isLoading.value = true;
    debugPrint(';;;;;;;;;;;;;;;;;; $orderId ;;;;;;;;;;;;;;;;;;;');
    String token = LocalStorage.getData(key: AppConstant.accessToken);

    // var decodedToken = JwtDecoder.decode(token);
    //
    // String? id = decodedToken['_id']?.toString();
    //String? id = profileAndSettingsController.myProfileData.value?.id ?? '';

    var headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'application/json',
    };

    var map = {"orderFuelId": orderId};

    dynamic responseBody = await BaseClient.handleResponse(
      await BaseClient.postRequest(
        api: Api.createPayment,
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

  Future<void> paymentResults({required String paymentLink}) async {
    try {
      isLoading.value = true;

      var headers = {
        'Content-Type': "application/json",
      };

      var response =
      await BaseClient.getRequest(api: paymentLink, headers: headers);

      var responseBody = await BaseClient.handleResponse(response);

      if (responseBody['success'] = true) {
        //var paymentId = responseBody['data']['_id'].toString();
        // LocalStorage.saveData(key: AppConstant.paymentId, data: paymentId);
        // String id = LocalStorage.getData(key: AppConstant.paymentId);
        //debugPrint('::::::::::::::::: $id :::::::::::::::::');
        Get.offAll(() => PaymentSuccessView());
      } else {
        debugPrint("Error on Payment Result: $responseBody['message'] ");
      }
    } catch (e) {
      debugPrint("Error on Payment Result: $e");
      kSnackBar(
        message: "Error on Payment Result: $e",
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }


}
