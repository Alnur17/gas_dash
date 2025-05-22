
import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_dashboard/views/driver_dashboard_view.dart';
import 'package:gas_dash/common/widgets/custom_background.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../user/dashboard/views/dashboard_view.dart';
import '../../login/views/login_view.dart';
import '../../onboarding/views/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      chooseScreen();
    });
  }

  chooseScreen() {
    // Get accessToken just to check if logged in
    var userToken = LocalStorage.getData(key: AppConstant.accessToken);
   var  onboardingDone = LocalStorage.getData(key: AppConstant.onboardingDone);

    if (userToken != null) {
      // Get role string saved separately
      String? role = LocalStorage.getData(key: AppConstant.role);

      if (role == 'user') {
        Get.offAll(
              () => DashboardView(),
          transition: Transition.rightToLeft,
        );
      } else if (role == 'driver') {
        Get.offAll(
              () => DriverDashboardView(),
          transition: Transition.rightToLeft,
        );
      } else {
        // kSnackBar(
        //   message: 'Error, unknown role found',
        //   bgColor: AppColors.red,
        // );
        Get.offAll(
              () => LoginView(),
          transition: Transition.rightToLeft,
        );
      }
    } else {
      // No token, go to login
      if(onboardingDone != null){
        Get.offAll(
              () => LoginView(),
          transition: Transition.rightToLeft,
        );
      }else{
        Get.offAll(
              () => OnboardingView(),
          transition: Transition.rightToLeft,
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: CustomBackground(
        child: Center(
          child: Image.asset(
            AppImages.splashLogo,
            scale: 4,
          ),
        ),
      ),
    );
  }
}

