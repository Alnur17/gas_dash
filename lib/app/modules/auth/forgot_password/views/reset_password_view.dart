import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/forgot_password/views/reset_success_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_textfield.dart';

class ResetPasswordView extends GetView {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Reset Password'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh20,
            Text(
              'Enter your new password and make sure you remember it',
              style: h5,
              textAlign: TextAlign.center,
            ),
            sh16,
            Text(
              'New password',
              style: h4,
            ),
            sh12,
            CustomTextField(
              hintText: '**********',
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
            ),
            sh16,
            Text(
              'Re-type New Password',
              style: h4,
            ),
            sh12,
            CustomTextField(
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
              hintText: '**********',
            ),
            sh16,
            CustomButton(
              text: 'Update Password',
              onPressed: () {
                Get.offAll(()=> ResetSuccessView());
              },
              gradientColors: AppColors.gradientColor,
            ),
          ],
        ),
      ),
    );
  }
}
