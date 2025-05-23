import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_dash/app/modules/auth/forgot_password/views/reset_password_view.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../controllers/forgot_password_controller.dart';

class VerifyOtpView extends StatefulWidget {
  final String email;

  const VerifyOtpView({super.key, required this.email});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final TextEditingController otpTEController = TextEditingController();
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('OTP Verification',style: titleStyle,),
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
              'We have sent code to ${widget.email} to verify your registration',
              style: h5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            PinCodeTextField(
              controller: otpTEController,
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
            Obx(
                  () => forgotPasswordController.isLoading.value == true
                  ? CustomLoader(color: AppColors.white)
                  : CustomButton(
                text: 'Confirm',
                onPressed: () {
                  forgotPasswordController.verifyOtp(
                    email: widget.email,
                    otp: otpTEController.text,
                  );
                },
                gradientColors: AppColors.gradientColor,
              ),
            ),
            sh30,
            Obx(() {
              return forgotPasswordController.isResendLoading.value == true
                  ? CircularProgressIndicator(color: AppColors.primaryColor,)
                  : forgotPasswordController.countdown.value > 0
                  ? Text(
                'Haven’t got the code yet? ${forgotPasswordController.countdown.value}',
                style: h3,
              )
                  : GestureDetector(
                onTap: forgotPasswordController.countdown.value == 0
                    ? () {
                  forgotPasswordController.reSendOtp(email: widget.email);
                }
                    : null,
                child:  Text(
                  'Resend code',
                  style: h3.copyWith(color: AppColors.primaryColor),
                ),
              );
            }),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'Haven’t got the code yet?',
            //       style: h5,
            //     ),
            //     sw5,
            //     Text(
            //       'Resent Code',
            //       style: h4.copyWith(color: Colors.cyan),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
