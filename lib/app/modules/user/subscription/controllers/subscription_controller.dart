import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/payment/controllers/payment_controller.dart';
import 'package:get/get.dart';

import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../model/subscription_package_model.dart';

class SubscriptionController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<Datum> packages = <Datum>[].obs;
  final RxString errorMessage = ''.obs;
  final paymentController = Get.put(PaymentController());


  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPackages();
  }

  Future<void> fetchSubscriptionPackages() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await BaseClient.getRequest(
        api: Api.subscriptionPackage,
        headers: {'Content-Type': 'application/json'},
      );

      final jsonData = await BaseClient.handleResponse(response);
      final subscriptionModel = SubscriptionPackageModel.fromJson(jsonData);

      if (subscriptionModel.success == true && subscriptionModel.data != null) {
        packages.assignAll(subscriptionModel.data!.data);
      } else {
        errorMessage(subscriptionModel.message ?? 'Failed to load packages');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> createSubscription({
    required String packageId,
  })
  async {
    try {
      isLoading.value = true;
      String accessToken = LocalStorage.getData(key: AppConstant.accessToken);
      var body = {
        'package': packageId,
        'durationType': 'monthly',
      };
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      debugPrint(';;;;;;;;;;;;;;;;;;; $headers ::::::::::::::::');

      var response = await BaseClient.postRequest(
        api: Api.subscriptionCreate,
        body: jsonEncode(body),
        headers: headers,
      );

      var responseBody = await BaseClient.handleResponse(response);
      if (responseBody['success'] = true) {
        String subscriptionId = responseBody['data']['_id'].toString();
        LocalStorage.saveData(key: AppConstant.subscriptionId, data: subscriptionId);
        String? subsId = LocalStorage.getData(key: AppConstant.subscriptionId);
        if (subsId != null) {
          paymentController.createPaymentSession(orderId: subsId);
          debugPrint(';;;;;;;;;;;;;;;;;; $subsId ;;;;;;;;;;;;;;;;;;;');
        } else {
          debugPrint('Failed to retrieve subscription ID from LocalStorage');
        }
      }
    } catch (e) {
      debugPrint("subscription failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}