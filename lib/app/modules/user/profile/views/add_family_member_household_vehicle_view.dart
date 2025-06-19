import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/order_fuel/controllers/order_fuel_controller.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/profile_controller.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_list_tile.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../controllers/vehicle_add_controller.dart';

class AddFamilyMemberPopup extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ProfileController profileController = Get.put(ProfileController());

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
          Text(
            'Email',
          ),
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
  final VehicleAddController orderFuelController =
      Get.put(VehicleAddController());

  AddVehicleDetailsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('Add Vehicle Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Make',
          ),
          CustomTextField(
            controller: orderFuelController.makeController,
          ),
          sh16,
          Text(
            'Model',
          ),
          CustomTextField(
            controller: orderFuelController.modelController,
          ),
          sh16,
          Text(
            'Year',
          ),
          CustomTextField(
            controller: orderFuelController.yearController,
          ),
          sh16,
          Text(
            'Fuel Level',
          ),
          CustomTextField(
            controller: orderFuelController.fuelLevelController,
          ),
          sh24,
          CustomButton(
            text: 'Confirmed',
            onPressed: () {
              orderFuelController.confirmVehicle();
            },
            gradientColors: AppColors.gradientColorGreen,
          ),
        ],
      ),
    );
  }
}

class AddFamilyMemberHouseholdVehicleView extends GetView {
  const AddFamilyMemberHouseholdVehicleView({super.key});

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
            CustomListTile(
              onTap: () {
                Get.dialog(AddFamilyMemberPopup());
              },
              leadingImage: AppImages.family,
              title: 'Add Family member ',
            ),
            sh12,
            CustomListTile(
              onTap: () {
                Get.dialog(AddVehicleDetailsPopup());
              },
              leadingImage: AppImages.family,
              title: 'Add household vehicle',
            ),
          ],
        ),
      ),
    );
  }
}
