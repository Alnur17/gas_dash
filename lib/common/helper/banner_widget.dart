import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/conditions_controller.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  final ConditionsController settingsController;
  final String Function(dynamic) bannerSelector; // Function to select banner field

  const BannerWidget({
    super.key,
    required this.settingsController,
    required this.bannerSelector,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (settingsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final data = settingsController.conditionsModel.value.data;
      if (data == null || data.isEmpty) {
        return Container(
          height: 180,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.silver,
          ),
        );
      }
      return Container(
        height: 180,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.silver,
          image: DecorationImage(
            image: NetworkImage(bannerSelector(data[0]).toString()),
            scale: 4,
            fit: BoxFit.cover,
          ),
        ),
      );
    });
  }
}