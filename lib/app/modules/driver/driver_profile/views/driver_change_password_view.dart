import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_profile/controllers/driver_profile_controller.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../../common/widgets/custom_textfield.dart';

class DriverChangePasswordView extends StatefulWidget {
  const DriverChangePasswordView({super.key});

  @override
  State<DriverChangePasswordView> createState() =>
      _DriverChangePasswordViewState();
}

class _DriverChangePasswordViewState extends State<DriverChangePasswordView> {
  final DriverProfileController driverProfileController =
      Get.put(DriverProfileController());
  final TextEditingController currentPassTEController = TextEditingController();
  final TextEditingController newPassTEController = TextEditingController();
  final TextEditingController confirmPassTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Change Password',
          style: titleStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sh30,
            Text(
              'Current Password',
              style: h5,
            ),
            sh8,
            Obx(
              () => CustomTextField(
                controller: currentPassTEController,
                hintText: '***********',
                sufIcon: GestureDetector(
                    onTap: () {
                      driverProfileController.togglePasswordVisibility();
                    },
                    child: Image.asset(
                        driverProfileController.isPasswordVisible.value
                            ? AppImages.eyeOpen
                            : AppImages.eyeClose,
                        scale: 4)),
                obscureText: !driverProfileController.isPasswordVisible.value,
              ),
            ),
            sh16,
            Text(
              'New Password',
              style: h5,
            ),
            sh8,
            Obx(
              () => CustomTextField(
                controller: newPassTEController,
                hintText: '***********',
                sufIcon: GestureDetector(
                    onTap: () {
                      driverProfileController.togglePasswordVisibility1();
                    },
                    child: Image.asset(
                        driverProfileController.isPasswordVisible1.value
                            ? AppImages.eyeOpen
                            : AppImages.eyeClose,
                        scale: 4)),
                obscureText: !driverProfileController.isPasswordVisible1.value,
              ),
            ),
            sh16,
            Text(
              'Re-type New Password',
              style: h5,
            ),
            sh8,
            Obx(
              () => CustomTextField(
                controller: confirmPassTEController,
                hintText: '***********',
                sufIcon: GestureDetector(
                    onTap: () {
                      driverProfileController.togglePasswordVisibility2();
                    },
                    child: Image.asset(
                        driverProfileController.isPasswordVisible2.value
                            ? AppImages.eyeOpen
                            : AppImages.eyeClose,
                        scale: 4)),
                obscureText: !driverProfileController.isPasswordVisible2.value,
              ),
            ),
            sh30,
            Obx(
              () => driverProfileController.isLoading.value == true
                  ? CustomLoader(
                      color: AppColors.white,
                    )
                  : CustomButton(
                      text: 'Confirm',
                      onPressed: () {
                        driverProfileController.driverChangePassword(
                          currentPassword: currentPassTEController.text,
                          newPassword: newPassTEController.text,
                          confirmPassword: confirmPassTEController.text,
                          context: context,
                        );
                      },
                      gradientColors: AppColors.gradientColorGreen,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
