import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_list_tile.dart';

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
              onTap: () {},
              leadingImage: AppImages.family,
              title: 'Add Family member ',
            ),
            sh12,
            CustomListTile(
              onTap: () {},
              leadingImage: AppImages.family,
              title: 'Add household vehicle',
            ),
          ],
        ),
      ),
    );
  }
}
