import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/data/api.dart';
import 'package:gas_dash/app/modules/user/order_fuel/views/fuel_type_final_confirmation_view.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../../../../data/base_client.dart';
import '../../jump_start_car_battery/views/final_confirmation_view.dart';
import '../model/final_confirmation_model.dart';
import '../model/vechicle_model.dart';

class OrderFuelController extends GetxController {
  // TextEditingControllers for text fields
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController fuelLevelController = TextEditingController();
  final TextEditingController customAmountController = TextEditingController();

  final isLoading = false.obs;
  // Observable for final confirmation data
  final finalConfirmation = Rxn<FinalConfirmationModel>();

  // Observables for selected values
  var currentLocation = 'Fetching location...'.obs;
  var latitude = RxnDouble();
  var longitude = RxnDouble();
  var zipCode = RxnString();

  var selectedMake = RxnString();
  var selectedModel = RxnString();
  var selectedYear = RxnString();
  var confirmedVehicle = Rxn<Map<String, String>>();
  var userId = RxnString();

  var vehiclesList = <Datum>[].obs;
  var selectedVehicle = Rxn<Datum>();
  var presetEnabled = false.obs;
  var customEnabled = false.obs;
  var customAmountText = ''.obs;
  var selectedPresetAmount = '5 gallons'.obs;

  final presetAmounts = [
    '5 gallons',
    '10 gallons',
    '15 gallons',
    '20 gallons',
    '25 gallons',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchCurrentLocation();
    selectedMake.listen((value) {
      makeController.text = value ?? '';
      if (value == null) {
        modelController.clear();
        selectedModel.value = null;
      }
    });
    selectedModel.listen((value) {
      modelController.text = value ?? '';
    });
    selectedYear.listen((value) {
      yearController.text = value ?? '';
    });
    customAmountController.addListener(() {
      customAmountText.value = customAmountController.text;
    });
  }

  void promptForZipCode() {
    final TextEditingController zipController = TextEditingController();
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Enter Zip Code',
                  style: h3.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Enter zip code (e.g., 90001)',
                controller: zipController,
                onChange: (value) {
                  zipCode.value = value;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Confirm',
                onPressed: () {
                  if (zipCode.value != null &&
                      zipCode.value!.isNotEmpty &&
                      RegExp(r'^\d{5}$').hasMatch(zipCode.value!)) {
                    Get.back(); // Close dialog
                  } else {
                    Get.snackbar(
                        'Error', 'Please enter a valid 5-digit zip code',
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                gradientColors: AppColors.gradientColorGreen,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  double parseGallons(String amount) {
    try {
      return double.parse(amount.replaceAll(' gallons', ''));
    } catch (e) {
      return 0.0;
    }
  }

  String calculatePrice(double gallons, double? fuelPrice) {
    if (fuelPrice != null) {
      double totalPrice = gallons * fuelPrice;
      return '\$${totalPrice.toStringAsFixed(2)}';
    }
    return '\$0.00';
  }

  void togglePreset() {
    presetEnabled.value = !presetEnabled.value;
    if (presetEnabled.value) customEnabled.value = false;
  }

  void toggleCustom() {
    customEnabled.value = !customEnabled.value;
    if (customEnabled.value) presetEnabled.value = false;
  }

  Future<void> createOrder({
    bool? isEmergency,
    required String vehicleId,
    required bool presetAmount,
    required bool customAmount,
    required double amount,
    required String fuelType,
  }) async {
    isLoading.value = true;
    try {
      final String token = LocalStorage.getData(key: AppConstant.accessToken);
      final Map<String, dynamic> orderData = {
        'location': {
          'coordinates': [
            longitude.value ?? 90.4125,
            latitude.value ?? 23.8103,
          ],
        },
        'vehicleId': vehicleId,
        'presetAmount': presetAmount,
        'customAmount': customAmount,
        'amount': amount,
        'fuelType': fuelType,
        'orderType': 'Fuel',
        'zipCode': zipCode.value ?? '90001',
        'emergency': isEmergency ?? false,
        'cancelReason': '',
      };

      String body = jsonEncode(orderData);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await BaseClient.postRequest(
        api: Api.createOrder,
        body: body,
        headers: headers,
      );

      var responseData = await BaseClient.handleResponse(response);
      if (responseData != null) {
        String? orderId = responseData['data']?['_id'];
        if (orderId == null) {
          Get.snackbar('Error', 'Failed to retrieve order ID',
              snackPosition: SnackPosition.BOTTOM);
          return;
        }

        kSnackBar(
          message: 'Order created successfully!',
          bgColor: AppColors.green,
        );
        Get.to(() => FuelTypeFinalConfirmationView(orderId: orderId));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrderForServices({
    required String vehicleId,
    required String orderType,
  }) async {
    try {
      isLoading.value = true;

      final String token = LocalStorage.getData(key: AppConstant.accessToken);
      final Map<String, dynamic> orderData = {
        'location': {
          'coordinates': [
            longitude.value ?? 90.4125,
            latitude.value ?? 23.8103,
          ],
        },
        'vehicleId': vehicleId,
        'orderType': orderType,
        'zipCode': zipCode.value ?? '90001',
        'cancelReason': '',
      };

      String body = jsonEncode(orderData);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await BaseClient.postRequest(
        api: Api.createOrder,
        body: body,
        headers: headers,
      );

      var responseData = await BaseClient.handleResponse(response);
      if (responseData != null) {
        String? orderId = responseData['data']?['_id'];
        if (orderId == null) {
          Get.snackbar('Error', 'Failed to retrieve order ID',
              snackPosition: SnackPosition.BOTTOM);
          return;
        }

        kSnackBar(
          message: 'Order created successfully!',
          bgColor: AppColors.green,
        );
        Get.to(() => FinalConfirmationView(orderId: orderId));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<FinalConfirmationModel?> fuelTypeFinalConfirmation(String id) async {
    try {
      isLoading.value = true;
      final String token = LocalStorage.getData(key: AppConstant.accessToken);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await BaseClient.getRequest(
        api: Api.orderDataConfirmation(id),
        headers: headers,
      );

      var responseData = await BaseClient.handleResponse(response);
      if (responseData != null) {
        FinalConfirmationModel orderModel =
        FinalConfirmationModel.fromJson(responseData);
        if (orderModel.success == true && orderModel.data != null) {
          finalConfirmation.value = orderModel; // Store in observable
          kSnackBar(
            message:
            orderModel.message ?? 'Order details fetched successfully!',
            bgColor: AppColors.green,
          );
          return orderModel;
        } else {
          finalConfirmation.value = null;
          Get.snackbar(
              'Error', orderModel.message ?? 'Failed to fetch order details',
              snackPosition: SnackPosition.BOTTOM);
          return null;
        }
      } else {
        finalConfirmation.value = null;
        Get.snackbar('Error', 'Failed to fetch order details',
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
    } catch (e) {
      finalConfirmation.value = null;
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> showVehicleSelectionDialog() async {
    await fetchMyVehicles();
    if (vehiclesList.isEmpty) {
      Get.snackbar('No Vehicles', 'No vehicles found. Please add a vehicle.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    selectedVehicle.value = null;

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Select Vehicle',
                  style: h3.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => Column(
                children: vehiclesList.map((vehicle) {
                  return RadioListTile<Datum>(
                    value: vehicle,
                    groupValue: selectedVehicle.value,
                    onChanged: (Datum? value) {
                      selectedVehicle.value = value;
                    },
                    title: Text(
                      '${vehicle.year} ${vehicle.make} ${vehicle.model}',
                      style: h5,
                    ),
                    secondary: Image.asset(
                      AppImages.car,
                      scale: 4,
                    ),
                  );
                }).toList(),
              )),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Confirm',
                onPressed: () {
                  if (selectedVehicle.value != null) {
                    confirmedVehicle.value = {
                      'make': selectedVehicle.value!.make!,
                      'model': selectedVehicle.value!.model!,
                      'year': selectedVehicle.value!.year.toString(),
                      'fuelLevel': selectedVehicle.value!.fuelLevel.toString(),
                    };
                    Get.back();
                    kSnackBar(
                        message: 'Vehicle selected successfully!',
                        bgColor: AppColors.green);
                  } else {
                    Get.snackbar('Error', 'Please select a vehicle',
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                gradientColors: AppColors.gradientColorGreen,
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Cancel',
                    style: h5.copyWith(color: AppColors.blueLight),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> fetchMyVehicles() async {
    try {
      isLoading.value = true;

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
        vehiclesList.value = vehicleModel.data!.data;
      } else {
        vehiclesList.clear();
        Get.snackbar(
            'Error', vehicleModel.message ?? 'Failed to load vehicles');
      }
    } catch (e) {
      vehiclesList.clear();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCurrentLocation() async {
    try {
      isLoading.value = true;

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        currentLocation.value = 'Location services are disabled.';
        zipCode.value = null;
        promptForZipCode();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          currentLocation.value = 'Location permissions are denied.';
          zipCode.value = null;
          promptForZipCode();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        currentLocation.value = 'Location permissions are permanently denied.';
        zipCode.value = null;
        promptForZipCode();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      List<Placemark> placeMarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks.first;
        currentLocation.value =
        '${place.street}, ${place.subLocality}, ${place.locality}';
        zipCode.value = place.postalCode ?? '';
        if (zipCode.value!.isEmpty) {
          promptForZipCode();
        }
      } else {
        currentLocation.value = 'Address not found.';
        zipCode.value = '';
        promptForZipCode();
      }
    } catch (e) {
      currentLocation.value = 'Failed to get location: $e';
      zipCode.value = '';
      promptForZipCode();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    customAmountController.dispose();
    makeController.dispose();
    modelController.dispose();
    yearController.dispose();
    fuelLevelController.dispose();
    super.onClose();
  }

  void resetForm() {
    selectedMake.value = null;
    selectedModel.value = null;
    selectedYear.value = null;
    makeController.clear();
    modelController.clear();
    yearController.clear();
    fuelLevelController.clear();
  }

  Future<void> confirmVehicle() async {
    isLoading.value = true;

    if (makeController.text.isEmpty ||
        modelController.text.isEmpty ||
        yearController.text.isEmpty ||
        fuelLevelController.text.isEmpty) {
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
      'fuelLevel': fuelLevelController.text,
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
}