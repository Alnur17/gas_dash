import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/conditions_controller.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  final ConditionsController settingsController;
  final String Function(dynamic) bannerSelector;

  const BannerWidget({
    super.key,
    required this.settingsController,
    required this.bannerSelector,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (settingsController.isLoading.value) {
        return const Center(child: CircularProgressIndicator(color: AppColors.textColor,));
      }
      final data = settingsController.conditionsModel.value.data;
      if (data.isEmpty) {
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
      return CachedNetworkImage(
        imageUrl: bannerSelector(data[0]).toString(),
        imageBuilder: (context, imageProvider) => Container(
          height: 180,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.silver,
            image: DecorationImage(
              image: imageProvider,
              scale: 4,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          height: 180,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.silver,
          ),
          //child: const Center(child: CircularProgressIndicator(color: AppColors.textColor,)),
        ),
        errorWidget: (context, url, error) => Container(
          height: 180,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.silver,
          ),
        ),
      );
    });
  }
}