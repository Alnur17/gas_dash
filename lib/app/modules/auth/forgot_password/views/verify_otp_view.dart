import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/forgot_password/views/reset_password_view.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';

class VerifyOtpView extends GetView {
  const VerifyOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('OTP Verification'),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            sh20,
            // Text(
            //   'Verify Your Identity',
            //   style: h3,
            // ),
            // sh20,
            Text(
              'We have sent code to tan@mail.com to verify your registration',
              style: h5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            PinCodeTextField(
              length: 6,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 60,
                fieldWidth: 50,
                // Reduce the width slightly for the gap
                activeColor: AppColors.white,
                activeFillColor: AppColors.white,
                inactiveColor: AppColors.borderColor,
                inactiveFillColor: AppColors.white,
                selectedColor: AppColors.blue,
                selectedFillColor: AppColors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: AppColors.transparent,
              cursorColor: AppColors.blue,
              enablePinAutofill: true,
              enableActiveFill: true,
              onCompleted: (v) {},
              onChanged: (value) {},
              beforeTextPaste: (text) {
                log("Allowing to paste $text");
                return true;
              },
              appContext: context,
            ),
            sh20,
            CustomButton(
              text: 'Confirm',
              onPressed: () {
                Get.to(() => const ResetPasswordView());
              },
              gradientColors: AppColors.gradientColor,
            ),
            sh30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Haven’t got the code yet?',
                  style: h5,
                ),
                sw5,
                Text('Resent Code',style: h4.copyWith(color: Colors.cyan),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
