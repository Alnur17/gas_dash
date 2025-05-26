import 'package:get/get.dart';

import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../model/fuel_info_model.dart';
import '../model/service_model.dart';

class HomeController extends GetxController {
  var fuelInfo = Rxn<FuelInfoModel>();
  var services = <ServiceData>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

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
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await BaseClient.getRequest(api: Api.fuelInfo);

      final data = await BaseClient.handleResponse(response);

      fuelInfo.value = FuelInfoModel.fromJson(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
