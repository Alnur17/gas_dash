import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/login/views/login_view.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_text_style/styles.dart';

class ResetSuccessView extends GetView {
  const ResetSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.verifySuccess,
              scale: 4,
            ),
            sh20,
            Text(
              'Success',
              style: h2,
            ),
            sh5,
            Text(
              'Your password has been successfully reset',
              style: h3.copyWith(
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            sh20,
            CustomButton(
              text: 'Done',
              onPressed: () {
                Get.offAll(()=> LoginView());
              },
              gradientColors: AppColors.gradientColor,
            ),
          ],
        ),
      ),
    );
  }
}
