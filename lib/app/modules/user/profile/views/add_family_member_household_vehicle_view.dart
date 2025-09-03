import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/profile_controller.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../controllers/vehicle_add_controller.dart';

class AddFamilyMemberPopup extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ProfileController profileController = Get.put(ProfileController());
  final VehicleAddController vehicleAddController =
      Get.put(VehicleAddController());

  AddFamilyMemberPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('Add Family Member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User Name'),
          CustomTextField(
            controller: usernameController,
          ),
          sh16,
          Text('Email'),
          CustomTextField(
            controller: emailController,
          ),
          sh24,
          CustomButton(
            text: 'Confirmed',
            onPressed: () {
              profileController.updateProfileForFamily(
                context: context,
                name: usernameController.text,
                email: emailController.text,
              );
            },
            gradientColors: AppColors.gradientColorGreen,
          ),
        ],
      ),
    );
  }
}

class AddVehicleDetailsPopup extends StatelessWidget {
  final VehicleAddController vehicleAddController =
      Get.put(VehicleAddController());

  AddVehicleDetailsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('Add Vehicle Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Make'),
            CustomTextField(
              controller: vehicleAddController.makeController,
            ),
            sh16,
            Text('Model'),
            CustomTextField(
              controller: vehicleAddController.modelController,
            ),
            sh16,
            Text('Year'),
            CustomTextField(
              controller: vehicleAddController.yearController,
            ),
            sh16,
            Text('Fuel Level'),
            CustomTextField(
              controller: vehicleAddController.fuelLevelController,
            ),
            sh24,
            CustomButton(
              text: 'Confirmed',
              onPressed: () {
                vehicleAddController.confirmVehicle();
              },
              gradientColors: AppColors.gradientColorGreen,
            ),
          ],
        ),
      ),
    );
  }
}

class AddFamilyMemberHouseholdVehicleView extends GetView {
  final ProfileController profileController = Get.put(ProfileController());
  final VehicleAddController vehicleAddController =
      Get.put(VehicleAddController());

  AddFamilyMemberHouseholdVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text('Add', style: titleStyle),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sh20,
            // Family Member Card or Add Card
            Obx(() {
              final familyMemberName =
                  profileController.myProfileData.value?.familyMember?.name ??
                      "";

              final familyMemberEmail =
                  profileController.myProfileData.value?.familyMember?.email ??
                      "";
              if (familyMemberName != '' && familyMemberEmail != '') {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.asset(AppImages.family, scale: 4),
                    title: Text(
                      familyMemberName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      familyMemberEmail,
                      style: TextStyle(color: Colors.pink, fontSize: 14),
                    ),
                  ),
                );
              } else {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.asset(AppImages.family, scale: 4),
                    title: Text(
                      'Add Family Member',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.dialog(AddFamilyMemberPopup());
                    },
                  ),
                );
              }
            }),
            // Vehicle Card or Add Card
            Obx(() {
              print("${vehicleAddController.myVehicleList.length}" +
                  ">>>>>>>>>>>>>>>>>>>");
              if (vehicleAddController.myVehicleList.isNotEmpty) {
                final vehicle =
                    vehicleAddController.myVehicleList[0]; // First vehicle
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.asset(AppImages.car, scale: 4),
                    title: Text(
                      '${vehicle.make}, ${vehicle.year} ~${vehicle.fuelLevel}% fuel',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Household vehicle',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                );
              } else {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: ListTile(
                    leading: Image.asset(AppImages.family, scale: 4),
                    title: Text(
                      'Add Household Vehicle',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.dialog(AddVehicleDetailsPopup());
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
