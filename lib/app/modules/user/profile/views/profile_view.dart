import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/profile/views/change_password_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/edit_profile_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/policies_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/terms_and_conditions_view.dart';
import 'package:gas_dash/app/modules/user/subscription/views/subscription_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_list_tile.dart';
import '../../../auth/login/views/login_view.dart';
import '../controllers/profile_controller.dart';


class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(AppImages.profileImageTwo),
            ),
            sh8,
            Text(
              'Daniel Martinez',
              style: h5.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            sh20,
            CustomListTile(
              onTap: () {
                Get.to(()=> EditProfileView());
              },
              leadingImage: AppImages.editProfile,
              title: 'Edit Profile',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(()=> ChangePasswordView());
              },
              leadingImage: AppImages.changePass,
              title: 'Change  Password ',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(()=> SubscriptionView());
              },
              leadingImage: AppImages.subscription,
              title: 'Subscription',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,

            CustomListTile(
              onTap: () {
                Get.to(()=> TermsAndConditionsView());
              },
              leadingImage: AppImages.termsAndConditions,
              title: 'Terms and conditions',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(()=> PoliciesView());
              },
              leadingImage: AppImages.policy,
              title: 'Privacy and Policies',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.offAll(()=> LoginView());
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
