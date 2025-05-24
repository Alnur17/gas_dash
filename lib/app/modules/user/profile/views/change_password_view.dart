import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../controllers/profile_controller.dart';

class ChangePasswordView extends GetView {
  ChangePasswordView({super.key});

  final ProfileController profileController = Get.put(ProfileController());
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
            CustomTextField(
              controller: currentPassTEController,
              hintText: '***********',
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
            ),
            sh16,
            Text(
              'New Password',
              style: h5,
            ),
            sh8,
            CustomTextField(
              controller: newPassTEController,
              hintText: '***********',
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
            ),
            sh16,
            Text(
              'Re-type New Password',
              style: h5,
            ),
            sh8,
            CustomTextField(
              controller: confirmPassTEController,
              hintText: '***********',
              sufIcon: Image.asset(
                AppImages.eyeClose,
                scale: 4,
              ),
            ),
            sh30,
            Obx(
              () => profileController.isLoading.value == true
                  ? CustomLoader(
                      color: AppColors.white,
                    )
                  : CustomButton(
                      text: 'Confirm',
                      onPressed: () {
                        profileController.changePassword(
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
