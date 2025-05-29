import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/jump_start_car_battery/views/final_confirmation_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/earnings_card.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../../common/helper/location_card.dart';
import '../../../../../common/helper/vehicle_card.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../order_fuel/controllers/order_fuel_controller.dart';
import '../controllers/jump_start_car_battery_controller.dart';

class JumpStartCarBatteryView extends GetView<JumpStartCarBatteryController> {
  JumpStartCarBatteryView({super.key});

  final OrderFuelController orderFuelController =
      Get.put(OrderFuelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 2,
          ),
        ),
        title: Text(
          'Jump Start Car Battery',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            sh16,
            EarningsCard(
              title: 'Jump Start Car Battery',
              amount: '25',
              gradientColor: AppColors.gradientColorBlue,
            ),
            sh20,
            Obx(
              () => LocationCard(
                locationText: orderFuelController.currentLocation.value,
                buttonText: 'Change Location',
                onButtonPressed: () {},
              ),
            ),
            sh20,
            VehicleCard(
              onAddCarTap: () {},
              onSelectCarTap: () {},
              imageAssetPath: AppImages.addCar,
            ),
            sh20,
            CustomButton(
              text: 'Next',
              onPressed: () {
                Get.to(() => FinalConfirmationView());
              },
              gradientColors: AppColors.gradientColorGreen,
            ),
          ],
        ),
      ),
    );
  }
}
