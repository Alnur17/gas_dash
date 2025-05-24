import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_list_tile.dart';
import '../../../auth/login/views/login_view.dart';
import '../controllers/driver_profile_controller.dart';
import 'driver_change_password_view.dart';
import 'driver_edit_profile_view.dart';
import 'driver_policy_view.dart';
import 'driver_terms_and_conditions_view.dart';

class DriverProfileView extends GetView<DriverProfileController> {
  DriverProfileView({super.key});

  final driverProfileController = Get.put(DriverProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sh20,
            Obx(
              () => CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.white,
                backgroundImage: NetworkImage(
                    driverProfileController.driverProfileData.value?.image ??
                        AppImages.profileImageTwo),
              ),
            ),
            sh8,
            Obx(
              () => Text(
                driverProfileController.driverProfileName.value,
                style: h5.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            sh20,
            CustomListTile(
              onTap: () {
                Get.to(() => DriverEditProfileView());
              },
              leadingImage: AppImages.editProfile,
              title: 'Edit Profile',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(() => DriverChangePasswordView());
              },
              leadingImage: AppImages.changePass,
              title: 'Change  Password ',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(() => DriverTermsAndConditionsView());
              },
              leadingImage: AppImages.termsAndConditions,
              title: 'Terms and conditions',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(() => DriverPolicyView());
              },
              leadingImage: AppImages.policy,
              title: 'Privacy and Policies',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () async {
                await LocalStorage.removeData(key: AppConstant.accessToken);
                await LocalStorage.removeData(key: AppConstant.refreshToken);
                await LocalStorage.removeData(key: AppConstant.role);
                Get.offAll(() => LoginView());
              },
              leadingImage: AppImages.logout,
              title: 'Log Out',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh40,
          ],
        ),
      ),
    );
  }
}
