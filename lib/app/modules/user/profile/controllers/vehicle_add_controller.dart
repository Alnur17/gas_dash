import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/data/api.dart';
import 'package:gas_dash/app/data/base_client.dart';
import 'package:gas_dash/app/modules/user/order_fuel/controllers/order_fuel_controller.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:gas_dash/common/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

import '../../order_fuel/model/vechicle_model.dart';

class VehicleAddController extends GetxController{


  final isLoading = false.obs;

  var myVehicleList = <VehicleListData>[].obs;
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController colorTEController = TextEditingController();
  final TextEditingController licensePlateNumberTEController = TextEditingController();

  @override
  void onInit() {
    fetchMyVehicles();
    super.onInit();
  }


  Future<void> confirmVehicle() async {
    isLoading.value = true;

    if (makeController.text.isEmpty ||
        modelController.text.isEmpty ||
        yearController.text.isEmpty ||
        colorTEController.text.isEmpty ||
        licensePlateNumberTEController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!RegExp(r'^\d{4}$').hasMatch(yearController.text)) {
      Get.snackbar('Error', 'Please enter a valid 4-digit year',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final String token = LocalStorage.getData(key: AppConstant.accessToken);

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String? id = decodedToken['userId']?.toString();

    Map<String, String> vehicleData = {
      'make': makeController.text,
      'model': modelController.text,
      'year': yearController.text,
      'carColor': colorTEController.text,
      'licenseNumber': licensePlateNumberTEController.text,
      'userId': id.toString(),
    };
    String body = jsonEncode(vehicleData);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      http.Response response = await BaseClient.postRequest(
        api: Api.addVehicle,
        body: body,
        headers: headers,
      );

      var responseData = await BaseClient.handleResponse(response);
      if (responseData != null) {
        await fetchMyVehicles();
        Get.back();
        kSnackBar(
            message: 'Vehicle added successfully!', bgColor: AppColors.green);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

   fetchMyVehicles() async {
    final String token = LocalStorage.getData(key: AppConstant.accessToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await BaseClient.getRequest(
      api: Api.getMyVehicle,
      headers: headers,
    );
    final jsonBody = await BaseClient.handleResponse(response);

    VehicleModel vehicleModel = VehicleModel.fromJson(jsonBody);
    if (vehicleModel.success == true && vehicleModel.data != null) {
      myVehicleList.clear();
      myVehicleList.addAll(vehicleModel.data!.data);
    //  return vehicleModel.data!.data;
    } else {
      throw Exception(vehicleModel.message ?? 'Failed to load vehicles');
    }
  }

  @override
  void onClose() {
    makeController.dispose();
    modelController.dispose();
    yearController.dispose();
    colorTEController.dispose();
    licensePlateNumberTEController.dispose();
    super.onClose();
  }
}