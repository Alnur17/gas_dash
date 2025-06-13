
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
}
