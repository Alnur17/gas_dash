import 'package:get/get.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import 'package:gas_dash/app/modules/user/profile/model/conditions_model.dart';

class ConditionsController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var getAboutUs = ''.obs;
  var getTermsConditions = ''.obs;
  var getPrivacyPolicy = ''.obs;
  var conditionsModel = ConditionsModel(success: false, message: '', data: []).obs;

  @override
  void onInit() {
    super.onInit();
    fetchConditions();
  }

  Future<void> fetchConditions() async {
    try {
      isLoading(true);
      errorMessage('');

      String token = LocalStorage.getData(key: AppConstant.accessToken) ?? '';
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await BaseClient.getRequest(
        api: Api.conditions,
        headers: headers,
      );

      final data = await BaseClient.handleResponse(response);
      conditionsModel.value = ConditionsModel.fromJson(data);

      // Accessing the first item in the list safely
      if (conditionsModel.value.data.isNotEmpty) {
        getPrivacyPolicy.value = conditionsModel.value.data.first.privacyPolicy ?? '';
        getTermsConditions.value = conditionsModel.value.data.first.termsConditions ?? '';
      } else {
        errorMessage('No conditions data available.');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
