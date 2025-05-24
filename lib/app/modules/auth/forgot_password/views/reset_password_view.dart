import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/forgot_password/controllers/forgot_password_controller.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../../common/widgets/custom_textfield.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  final TextEditingController newPasswordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
  TextEditingController();

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
              controller: newPasswordTEController,
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
              controller: confirmPasswordTEController,
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
              hintText: '**********',
            ),
            sh16,
            Obx(
                  () => forgotPasswordController.isLoading.value == true
                  ? CustomLoader(color: AppColors.white)
                  : CustomButton(
                text: 'Update Password',
                onPressed: () {
                  forgotPasswordController.resetPassword(
                    newPassword: newPasswordTEController.text,
                    confirmPassword: confirmPasswordTEController.text,
                  );
                },
                gradientColors: AppColors.gradientColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
