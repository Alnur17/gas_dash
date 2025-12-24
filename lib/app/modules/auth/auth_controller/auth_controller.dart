import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_constant/app_constant.dart';
import '../../../../common/helper/local_store.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../driver/driver_dashboard/views/driver_dashboard_view.dart';
import '../../user/dashboard/views/dashboard_view.dart';
import 'apple_sign_in_service.dart';
import 'google_sign_in_service.dart';
import 'api_service.dart';

class AuthController extends GetxController {
  // final GoogleSignInService _googleSignInService = GoogleSignInService();
  // final ApiService _apiService = ApiService();
  // final AppleSignInService _appleSignInService = AppleSignInService();
  //
  //
  // var isLoadingGoogle = false.obs;
  // var isLoadingApple = false.obs;
  //
  // Future<void> loginWithGoogle() async {
  //   try {
  //     isLoadingGoogle.value = true;
  //
  //     final userData = await _googleSignInService.signInWithGoogle();
  //     if (userData == null) {
  //       Get.snackbar('Error', 'Google Sign-In canceled');
  //       return;
  //     }
  //
  //     final response = await _apiService.login(
  //       email: userData['email']!,
  //       fullname: userData['fullname']!, isGoogleLogin: true,
  //     );
  //
  //
  //
  //     // Handle response data (e.g., save token, navigate to home)
  //     print('Login response: $response');
  //
  //     String accessToken = response['data']['accessToken'].toString();
  //     LocalStorage.saveData(
  //       key: AppConstant.accessToken,
  //       data: accessToken,
  //     );
  //
  //     String userId = response['data']['user']['_id'].toString();
  //     LocalStorage.saveData(
  //       key: AppConstant.userId,
  //       data: userId,
  //     );
  //
  //     String refreshToken = response['data']['refreshToken'].toString();
  //     LocalStorage.saveData(
  //       key: AppConstant.refreshToken,
  //       data: refreshToken,
  //     );
  //
  //     String role =
  //     response['data']['user']['role'].toString().toLowerCase();
  //     LocalStorage.saveData(key: AppConstant.role, data: role);
  //     kSnackBar(message: "Logged in successfully", bgColor: AppColors.green);
  //
  //     if (role == 'user') {
  //       Get.offAll(() => DashboardView());
  //     } else if (role == 'driver') {
  //       Get.offAll(() => DriverDashboardView());
  //     } else {
  //       kSnackBar(message: 'Unknown role', bgColor: AppColors.red);
  //     }
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to login: $error');
  //   } finally {
  //     isLoadingGoogle.value = false;
  //   }
  // }
  //
  //
  // Future<void> loginWithApple() async {
  //   try {
  //     isLoadingApple.value = true;
  //
  //     final userData = await _appleSignInService.signInWithApple();
  //     if (userData == null) {
  //       Get.snackbar('Error', 'Apple Sign-In canceled');
  //       return;
  //     }
  //
  //     final response = await _apiService.login(
  //       email: userData['email']!,
  //       fullname: userData['fullname']!, isGoogleLogin: true,
  //     );
  //
  //     Get.snackbar('Success', 'Logged in successfully with Apple');
  //     // Handle response data (e.g., save token, navigate to home)
  //     print('Login response: $response');
  //     String accessToken = response['data']['accessToken'].toString();
  //     LocalStorage.saveData(
  //       key: AppConstant.accessToken,
  //       data: accessToken,
  //     );
  //
  //     String userId = response['data']['user']['_id'].toString();
  //     LocalStorage.saveData(
  //       key: AppConstant.userId,
  //       data: userId,
  //     );
  //
  //     String refreshToken = response['data']['refreshToken'].toString();
  //     LocalStorage.saveData(
  //       key: AppConstant.refreshToken,
  //       data: refreshToken,
  //     );
  //
  //     String role =
  //     response['data']['user']['role'].toString().toLowerCase();
  //     LocalStorage.saveData(key: AppConstant.role, data: role);
  //     kSnackBar(message: "Logged in successfully", bgColor: AppColors.green);
  //
  //     if (role == 'user') {
  //       Get.offAll(() => DashboardView());
  //     } else if (role == 'driver') {
  //       Get.offAll(() => DriverDashboardView());
  //     } else {
  //       kSnackBar(message: 'Unknown role', bgColor: AppColors.red);
  //     }
  //   } catch (error) {
  //     Get.snackbar('Error', 'Failed to login with Apple: $error');
  //   } finally {
  //     isLoadingApple.value = false;
  //   }
  // }
}