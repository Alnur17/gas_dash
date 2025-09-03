import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/app_color/app_colors.dart';
import '../../../../../../common/app_text_style/styles.dart';
import '../../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../../common/widgets/custom_textfield.dart';
import '../../app/modules/auth/sign_up/controllers/sign_up_controller.dart';
import '../app_images/app_images.dart';

class SignUpBodyWidget extends StatefulWidget {
  const SignUpBodyWidget({super.key});

  @override
  State<SignUpBodyWidget> createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  final SignUpController signupController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          sh16,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildRadioOption('Customer', 'user'),
              _buildRadioOption('Driver', 'driver'),
            ],
          ),
          sh16,
          Obx(
            () => signupController.selectedRole.value == 'user'
                ? _buildCustomerInterface()
                : signupController.selectedRole.value == 'driver'
                    ? _buildDriverInterface()
                    : SizedBox.shrink(),
          ),
          sh16,
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label, String value) {
    return Row(
      children: [
        Obx(
          () => Radio(
            value: value,
            groupValue: signupController.selectedRole.value,
            onChanged: (role) => signupController.selectRole(role!),
            activeColor: AppColors.green,
          ),
        ),
        Text(label,
            style: h4.copyWith(
              color: AppColors.black,
            )),
      ],
    );
  }

  Widget _buildCustomerInterface() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name',
          style: h5,
        ),
        sh8,
        CustomTextField(
          hintText: 'Full name',
          controller: signupController.fullNameController,
        ),
        sh24,
        Text(
          'Email',
          style: h5,
        ),
        sh8,
        CustomTextField(
          //preIcon: Image.asset(AppImages.message, scale: 4),
          hintText: 'Enter your email',
          controller: signupController.emailController,
        ),
        sh24,
        Text(
          'City and State',
          style: h5,
        ),
        sh8,
        CustomTextField(
          //preIcon: Image.asset(AppImages.message, scale: 4),
          hintText: 'Enter your city and state',
          controller: signupController.locationController,
        ),
        sh24,
        Text(
          'Country',
          style: h5,
        ),
        sh8,
        CustomTextField(
          //preIcon: Image.asset(AppImages.message, scale: 4),
          hintText: 'Enter your country name',
          controller: signupController.countryController,
        ),
        sh24,
        Text(
          'ZIP Code',
          style: h5,
        ),
        sh8,
        CustomTextField(
          //preIcon: Image.asset(AppImages.message, scale: 4),
          hintText: 'Enter your zip code',
          controller: signupController.zipCodeController,
        ),
        sh24,
        Text(
          'Password',
          style: h5,
        ),
        sh8,
        CustomTextField(
          sufIcon: GestureDetector(
              onTap: () {
                signupController.togglePasswordVisibility();
              },
              child: Image.asset(
                  signupController.isPasswordVisible.value
                      ? AppImages.eyeOpen
                      : AppImages.eyeClose,
                  scale: 4)),
          hintText: 'Enter your password',
          controller: signupController.passwordController,
          obscureText: !signupController.isPasswordVisible.value,
        ),
        sh24,
        Text(
          'Confirm Password',
          style: h5,
        ),
        sh8,
        CustomTextField(
          sufIcon: GestureDetector(
              onTap: () {
                signupController.togglePasswordVisibility2();
              },
              child: Image.asset(
                  signupController.isPasswordVisible2.value
                      ? AppImages.eyeOpen
                      : AppImages.eyeClose,
                  scale: 4)),
          obscureText: !signupController.isPasswordVisible2.value,
          hintText: 'Confirm your password',
          controller: signupController.confirmPasswordController,
        ),
      ],
    );
  }

  Widget _buildDriverInterface() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name',
          style: h5,
        ),
        sh8,
        CustomTextField(
          hintText: 'Full name',
          controller: signupController.driverFullNameController,
        ),
        sh24,
        Text(
          'Email',
          style: h5,
        ),
        sh8,
        CustomTextField(
          //preIcon: Image.asset(AppImages.message, scale: 4),
          hintText: 'Enter your email',
          controller: signupController.driverEmailController,
        ),
        sh24,
        Text(
          'Password',
          style: h5,
        ),
        sh8,
        CustomTextField(
          sufIcon: GestureDetector(
              onTap: () {
                signupController.togglePasswordVisibility();
              },
              child: Image.asset(
                  signupController.isPasswordVisible.value
                      ? AppImages.eyeOpen
                      : AppImages.eyeClose,
                  scale: 4)),
          obscureText: !signupController.isPasswordVisible.value,
          hintText: 'Enter your password',
          controller: signupController.driverPasswordController,
        ),
        sh24,
        Text(
          'Confirm Password',
          style: h5,
        ),
        sh8,
        CustomTextField(
          sufIcon: GestureDetector(
              onTap: () {
                signupController.togglePasswordVisibility2();
              },
              child: Image.asset(
                  signupController.isPasswordVisible2.value
                      ? AppImages.eyeOpen
                      : AppImages.eyeClose,
                  scale: 4)),
          obscureText: !signupController.isPasswordVisible2.value,
          hintText: 'Confirm your password',
          controller: signupController.driverConfirmPasswordController,
        ),
      ],
    );
  }
}
