import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/profile/views/change_password_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/edit_profile_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/policies_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/terms_and_conditions_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/track_your_order_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_list_tile.dart';
import '../../../auth/login/views/login_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getMyProfile();
  }

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
            // Profile section with avatar and name
            Obx(
                  () => CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.white,
                backgroundImage: NetworkImage(
                    profileController.myProfileData.value?.image ??
                        AppImages.profileImageTwo),
              ),
            ),
            sh8,
            Obx(
                  () => Text(
                    profileController.myProfileName.value,
                style: h5.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            sh20,
            CustomListTile(
              onTap: () {
                Get.to(() => EditProfileView());
              },
              leadingImage: AppImages.editProfile,
              title: 'Edit Profile',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(() => ChangePasswordView());
              },
              leadingImage: AppImages.changePass,
              title: 'Change Password',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(() => TrackYourOrderView());
              },
              leadingImage: AppImages.locationBlue,
              title: 'Track your Order',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            // Subscription tile
            CustomListTile(
              onTap: () {
                profileController.handleSubscriptionNavigation();
              },
              leadingImage: AppImages.subscription,
              title: 'Subscription',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            // Family member or household vehicle tile
            CustomListTile(
              onTap: () {
                profileController.handleFamilyMemberNavigation();
              },
              leadingImage: AppImages.family,
              title: 'Family member or\nhousehold vehicle',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(() => TermsAndConditionsView());
              },
              leadingImage: AppImages.termsAndConditions,
              title: 'Terms and conditions',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.to(() => PoliciesView());
              },
              leadingImage: AppImages.policy,
              title: 'Privacy and Policies',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {

                Get.dialog(
                  AlertDialog(
                    title: Text("Confirm Deletion"),
                    content: Text("Do you want to delete your account? This action cannot be undone."),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(), // Close dialog on "No"
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          profileController.deleteMyProfile();
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              leadingImage: AppImages.delete,
              title: 'Delete Profile',
              trailingImage: AppImages.arrowRightSmall,
            ),
            sh12,
            CustomListTile(
              onTap: () {

                Get.dialog(
                  AlertDialog(
                    title: Text("Confirm Logout"),
                    content: Text("Do you want to logout your account?"),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(), // Close dialog on "No"
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          LocalStorage.removeData(key: AppConstant.accessToken);
                          LocalStorage.removeData(key: AppConstant.refreshToken);
                          LocalStorage.removeData(key: AppConstant.role);
                          Get.offAll(() => LoginView());
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
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
