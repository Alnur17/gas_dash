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

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  final TextEditingController emailTEController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text('Forgot Password'),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sh20,
            Text(
              'We will send the OTP code to your email for security in forgetting your password',
              style: h5,
              textAlign: TextAlign.center,
            ),
            sh30,
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: h4,
                )),
            sh8,
            CustomTextField(
              controller: emailTEController,
              hintText: 'Enter your email',
            ),
            sh30,
            Obx(
                  () => forgotPasswordController.isLoading.value == true
                  ? CustomLoader(color: AppColors.white)
                  : CustomButton(
                text: 'Send',
                onPressed: () {
                  forgotPasswordController.forgotPassword(
                    email: emailTEController.text.toLowerCase(),
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
