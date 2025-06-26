import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_profile/controllers/driver_profile_controller.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../../common/widgets/custom_textfield.dart';

class DriverEditProfileView extends StatefulWidget {
  const DriverEditProfileView({super.key});

  @override
  State<DriverEditProfileView> createState() => _DriverEditProfileViewState();
}

class _DriverEditProfileViewState extends State<DriverEditProfileView> {
  final DriverProfileController driverProfileController =
      Get.put(DriverProfileController());

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
        driverProfileController.driverProfileData.value?.fullname ?? '';
    emailTEController.text =
        driverProfileController.driverProfileData.value?.email ?? '';
    locationTEController.text =
        (driverProfileController.driverProfileData.value?.location ?? '');
    contactTEController.text =
        driverProfileController.driverProfileData.value?.phoneNumber ?? '';
    zipCodeTEController.text =
        driverProfileController.driverProfileData.value?.zipCode ?? '';
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
        title: const Text('Edit Profile'),
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
                            backgroundImage: driverProfileController
                                        .selectedImage.value !=
                                    null
                                ? FileImage(driverProfileController
                                    .selectedImage.value!)
                                : (driverProfileController.driverProfileData
                                                .value?.image !=
                                            null &&
                                        driverProfileController
                                            .driverProfileData
                                            .value!
                                            .image!
                                            .isNotEmpty)
                                    ? NetworkImage(driverProfileController
                                        .driverProfileData.value!.image!)
                                    : NetworkImage(AppImages.profileImageTwo),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                driverProfileController.pickImage();
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
                        driverProfileController
                                .driverProfileData.value?.fullname ??
                            '',
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
                hintText: 'Enter your city and state',
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
                () => driverProfileController.isLoading.value == true
                    ? CustomLoader(
                        color: AppColors.white,
                      )
                    : CustomButton(
                        text: "Save",
                        gradientColors: AppColors.gradientColorGreen,
                        //backgroundColor: AppColors.textColorBlue,
                        onPressed: () {
                          driverProfileController.updateProfile(
                            name: nameTEController.text,
                            email: emailTEController.text.toLowerCase(),
                            contactNumber: contactTEController.text,
                            location: locationTEController.text,
                            zipCode: zipCodeTEController.text,
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
