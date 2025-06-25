import 'package:get/get.dart';

import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../model/fuel_info_model.dart';
import '../model/service_model.dart';

class HomeController extends GetxController {
  var fuelInfo = Rxn<FuelInfoModel>();
  var services = <ServiceData>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var fuelPricesPerGallon = <String, double>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getFuelInfo();
    fetchServices();
  }

  Future<void> fetchServices() async {
    try {
      isLoading(true);
      errorMessage('');

      const String apiUrl = Api.service;

      final response = await BaseClient.getRequest(
        api: apiUrl,
      );

      // Handle the response
      final jsonResponse = await BaseClient.handleResponse(response);

      final serviceModel = ServiceModel.fromJson(jsonResponse);

      if (serviceModel.success == true && serviceModel.data != null) {
        services.assignAll(serviceModel.data!.data);
      } else {
        errorMessage(serviceModel.message ?? 'Failed to load services');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> getFuelInfo() async {
    try {
      isLoading(true);
      errorMessage('');

      const String apiUrl = Api.fuelInfo;

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getData(key: AppConstant.accessToken)}',
      };


      final response = await BaseClient.getRequest(
        api: apiUrl,
        headers: headers,
      );

      final jsonResponse = await BaseClient.handleResponse(response);

      final fuelInfoModel = FuelInfoModel.fromJson(jsonResponse);

      if (fuelInfoModel.status == "success" && fuelInfoModel.data.isNotEmpty) {
        fuelInfo.value = fuelInfoModel;
        // Map fuel names to their prices (up to three or all available)
        fuelPricesPerGallon.assignAll({
          for (var datum in fuelInfoModel.data)
            datum.fuelName ?? 'Unknown Fuel': datum.fuelPrice ?? 0.0
        });
      } else {
        errorMessage('Failed to load fuel info');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}