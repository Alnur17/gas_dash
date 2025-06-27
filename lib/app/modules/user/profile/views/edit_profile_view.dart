
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ProfileController profileController = Get.find<ProfileController>();

  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController contactTEController = TextEditingController();
  final TextEditingController locationTEController = TextEditingController();
  final TextEditingController zipCodeTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    nameTEController.text =
        profileController.myProfileData.value?.fullname ?? '';
    emailTEController.text = profileController.myProfileData.value?.email ?? '';
    locationTEController.text =
        (profileController.myProfileData.value?.location ?? '');
    contactTEController.text =
        profileController.myProfileData.value?.phoneNumber ?? '';
    zipCodeTEController.text =
        profileController.myProfileData.value?.zipCode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.back,
              scale: 4,
            ),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh20,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: profileController
                                        .selectedImage.value !=
                                    null
                                ? FileImage(
                                    profileController.selectedImage.value!)
                                : (profileController
                                                .myProfileData.value?.image !=
                                            null &&
                                        profileController.myProfileData.value!
                                            .image!.isNotEmpty)
                                    ? NetworkImage(profileController
                                        .myProfileData.value!.image!)
                                    : NetworkImage(AppImages.profileImageTwo),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                profileController.pickImage();
                              },
                              child: const CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColors.black,
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  sh12,
                  Obx(
                    () => Align(
                      alignment: Alignment.center,
                      child: Text(
                        profileController.myProfileData.value?.fullname ?? '',
                        style: h5.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sh40,
              Text(
                'Personal Details',
                style: h3,
              ),
              sh20,
              Text(
                'Full Name',
                style: h5,
              ),
              sh8,
              CustomTextField(
                controller: nameTEController,
                hintText: 'Lukas Wagner',
              ),
              sh12,
              Text(
                'Email address',
                style: h5,
              ),
              sh8,
              CustomTextField(
                controller: emailTEController,
                hintText: 'lukas.wagner@gmail.com',
              ),
              sh12,
              Text(
                'Contact',
                style: h5,
              ),
              sh8,
              CustomTextField(
                controller: contactTEController,
                hintText: 'Your phone number',
              ),
              sh12,
              Text(
                'City and State',
                style: h5,
              ),
              sh8,
              CustomTextField(
                controller: locationTEController,
                hintText: 'Your location',
              ),
              sh12,
              Text(
                'ZIP Code',
                style: h5,
              ),
              sh8,
              CustomTextField(
                controller: zipCodeTEController,
                hintText: '34450',
              ),
              sh20,
              Obx(
                () => profileController.isLoading.value == true
                    ? CustomLoader(
                        color: AppColors.white,
                      )
                    : CustomButton(
                        text: "Save",
                        gradientColors: AppColors.gradientColorGreen,
                        //backgroundColor: AppColors.textColorBlue,
                        onPressed: () {
                          profileController.updateProfile(
                            name: nameTEController.text,
                            email: emailTEController.text.toLowerCase(),
                            contactNumber: contactTEController.text,
                            location: locationTEController.text,
                            zipCode: zipCodeTEController.text,
                            context: context,
                          );
                        },
                      ),
              ),
              sh20,
            ],
          ),
        ),
      ),
    );
  }
}
