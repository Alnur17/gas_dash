import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/modules/user/order_fuel/controllers/order_fuel_controller.dart';
import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class VehicleCard extends StatefulWidget {
  final VoidCallback onAddCarTap;
  final VoidCallback onSelectCarTap;
  final String imageAssetPath;

  const VehicleCard({
    super.key,
    required this.onAddCarTap,
    required this.imageAssetPath,
    required this.onSelectCarTap,
  });

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  final OrderFuelController controller = Get.find<OrderFuelController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.confirmedVehicle.value == null) ...[
            Row(
              children: [
                Image.asset(
                  widget.imageAssetPath,
                  scale: 4,
                ),
                sw12,
                Text(
                  'Add Vehicle',
                  style: h5.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            sh12,
            Row(
              children: [
                CustomButton(
                  text: 'Add',
                  onPressed: widget.onAddCarTap,
                  height: 40,
                  width: 100,
                  borderRadius: 8,
                  backgroundColor: Colors.blue[50],
                  imageAssetPath: AppImages.add,
                  iconColor: AppColors.blueLight,
                  textStyle: h5.copyWith(color: AppColors.blueLight),
                ),
                sw5,
                CustomButton(
                  text: 'Select Car',
                  onPressed: widget.onSelectCarTap, // Updated to call the new method
                  height: 40,
                  width: 130,
                  borderRadius: 8,
                  backgroundColor: Colors.blue[50],
                  imageAssetPath: AppImages.edit,
                  iconColor: AppColors.blueLight,
                  textStyle: h5.copyWith(color: AppColors.blueLight),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Image.asset(
                  AppImages.car,
                  scale: 4,
                ),
                sw12,
                Text(
                  '${controller.confirmedVehicle.value!['make']} ${controller.confirmedVehicle.value!['model']}, ${controller.confirmedVehicle.value!['year']}',
                  style: h5.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            sh12,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomButton(
                  text: 'Change',
                  onPressed: () {
                    controller.resetForm();
                    controller.confirmedVehicle.value = null;
                    widget.onAddCarTap();
                  },
                  height: 40,
                  width: 100,
                  borderRadius: 8,
                  backgroundColor: Colors.blue[50],
                  textStyle: h5.copyWith(color: AppColors.blueLight),
                ),
                sw12,
                CustomButton(
                  text: 'Remove',
                  onPressed: () {
                    controller.resetForm();
                    controller.confirmedVehicle.value = null;
                  },
                  height: 40,
                  width: 100,
                  borderRadius: 8,
                  backgroundColor: Colors.red[50],
                  textStyle: h5.copyWith(color: Colors.red),
                ),
              ],
            ),
          ],
        ],
      ),
    ));
  }
}
