import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/fuel_card.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../home/controllers/home_controller.dart';
import '../../order_fuel/views/order_fuel_view.dart';
import '../controllers/emergency_fuel_controller.dart';

class EmergencyFuelView extends GetView<EmergencyFuelController> {
   EmergencyFuelView({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'EmergencyFuelView',
          style: titleStyle,
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sh12,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Choose Your Fuel Type',
              style: h3.copyWith(
                fontSize: 18,
              ),
            ),
          ),
          sh16,
          FuelCard(
            title: 'UNLEADED',
            number: '87',
            buttonText: 'Order Now',
            gradientColors: AppColors.gradientColorBlue,
            onTap: () {
              final price =
                  homeController.fuelPricesPerGallon['Unleaded'] ?? 0.0;
              print(';;;;;;;;;; $price ;;;;;;;;;;;;;;;;;;');
              Get.to(() => OrderFuelView(
                fuelName: 'Unleaded',
                number: '87',
                fuelPrice: price,
              ));
            },
          ),
          sh16,
          FuelCard(
            title: 'PREMIUM',
            number: '91',
            buttonText: 'Order Now',
            gradientColors: AppColors.gradientColorGrey,
            onTap: () {
              final price =
                  homeController.fuelPricesPerGallon['Premium'] ?? 0.0;
              print(';;;;;;;;;; $price ;;;;;;;;;;;;;;;;;;');
              Get.to(() => OrderFuelView(
                fuelName: 'Premium',
                number: '91',
                fuelPrice: price,
              ));
            },
          ),
          sh16,
          FuelCard(
            title: 'DIESEL',
            number: '71',
            buttonText: 'Order Now',
            gradientColors: AppColors.gradientColorGreen,
            onTap: () {
              final price =
                  homeController.fuelPricesPerGallon['Diesel'] ?? 0.0;
              print(';;;;;;;;;; $price ;;;;;;;;;;;;;;;;;;');
              Get.to(() => OrderFuelView(
                fuelName: 'Diesel',
                number: '71',
                fuelPrice: price,
              ));
            },
          ),
        ],
      ),
    );
  }
}
