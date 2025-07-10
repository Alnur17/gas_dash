import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../model/coupon_model.dart';

class CouponController extends GetxController {
  var isLoading = false.obs;
  var couponModel = Rxn<CouponModel>();

  Future<void> checkCoupon(String couponValue) async {
    try {
      isLoading.value = true;

      // Prepare the API URL
      String apiUrl = Api.coupon(couponValue);

      // Make the GET request using BaseClient
      http.Response response = await BaseClient.getRequest(
        api: apiUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Handle the response
      var result = await BaseClient.handleResponse(response);

      // Parse the response into CouponModel
      couponModel.value = CouponModel.fromJson(result);

      // Show success message
      if (couponModel.value?.success == true) {
        kSnackBar(
          message: couponModel.value?.message ?? 'Coupon applied successfully!',
          bgColor: AppColors.green,
        );
      }
    } catch (e) {
      // Show error message
      kSnackBar(
        message: e.toString(),
        bgColor: AppColors.orange,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
