import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../model/fuel_info_model.dart';
import '../model/service_model.dart';

class HomeBannerController extends GetxController {

  var isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    getEmergencyBanner();
    getDiscountBanner();
  }

  Future<void> getEmergencyBanner() async {
    try {
      isLoading(true);

      const String apiUrl = Api.emergencyBanner;

      final response = await BaseClient.getRequest(
        api: apiUrl,
      );

      // Handle the response
      final responseBody = await BaseClient.handleResponse(response);



      if (responseBody != null) {

      } else {
        debugPrint('Failed to load services');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> getDiscountBanner() async {
    try {
      isLoading(true);


      const String apiUrl = Api.discountBanner;

      final response = await BaseClient.getRequest(
        api: apiUrl,
      );

      final responseBody = await BaseClient.handleResponse(response);



      if (responseBody != null) {
        ///
      } else {
        debugPrint('Failed to load fuel info');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}