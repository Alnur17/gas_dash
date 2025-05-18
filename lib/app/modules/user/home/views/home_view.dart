import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/home/views/notification_view.dart';
import 'package:gas_dash/app/modules/user/jump_start_car_battery/views/jump_start_car_battery_view.dart';
import 'package:gas_dash/app/modules/user/order_fuel/views/order_fuel_view.dart';
import 'package:gas_dash/app/modules/user/subscription/views/subscription_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_row_header.dart';

import 'package:get/get.dart';

import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/fuel_card.dart';
import '../../../../../common/helper/fuel_order_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Image.asset(
              AppImages.homeLogo,
              scale: 4,
            ),
            Text(
              'GAS DASH',
              style: h3.copyWith(fontWeight: FontWeight.w700),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(()=> NotificationView());
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: AppColors.silver,
                      ),
                    ),
                  ),
                  child: Image.asset(
                    AppImages.notification,
                    scale: 4,
                  )),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.silver),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(AppImages.profileImage),
                      ),
                      sw8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Clara',
                            style: h3.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Customer',
                            style: h6.copyWith(
                              color: AppColors.blueTurquoise,
                            ),
                          ),
                          Text(
                            'Subscription Type: Unsubscribed',
                            style: h6,
                          ),
                        ],
                      )
                    ],
                  ),
                  sh12,
                  CustomButton(
                    text: 'Manage Subscription',
                    onPressed: () {
                      Get.to(() => SubscriptionView());
                    },
                    gradientColors: AppColors.gradientColor,
                  ),
                ],
              ),
            ),
            sh16,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.silver),
                gradient: LinearGradient(
                  colors: AppColors.gradientColorBlue,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gas prices',
                      style: h3.copyWith(color: AppColors.white)),
                  sh8,
                  Row(
                    children: [
                      Image.asset(
                        AppImages.unleaded,
                        scale: 4,
                      ),
                      sw8,
                      Text(
                        'UNLEADED',
                        style: h3.copyWith(
                          fontSize: 14,
                          color: AppColors.white,
                        ),
                      ),
                      Spacer(),
                      CustomButton(
                        height: 40,
                        width: 100,
                        text: '3.79',
                        onPressed: () {},
                        borderRadius: 8,
                        backgroundColor: AppColors.blueTurquoise,
                      ),
                    ],
                  ),
                  sh12,
                  Row(
                    children: [
                      Image.asset(
                        AppImages.premium,
                        scale: 4,
                      ),
                      sw8,
                      Text(
                        'PREMIUM',
                        style: h3.copyWith(
                          fontSize: 14,
                          color: AppColors.white,
                        ),
                      ),
                      Spacer(),
                      CustomButton(
                        height: 40,
                        width: 100,
                        text: '3.79',
                        onPressed: () {},
                        borderRadius: 8,
                        backgroundColor: AppColors.grey,
                      ),
                    ],
                  ),
                  sh12,
                  Row(
                    children: [
                      Image.asset(
                        AppImages.diesel,
                        scale: 4,
                      ),
                      sw8,
                      Text(
                        'DIESEL',
                        style: h3.copyWith(
                          fontSize: 14,
                          color: AppColors.white,
                        ),
                      ),
                      Spacer(),
                      CustomButton(
                        height: 40,
                        width: 100,
                        text: '4.15',
                        onPressed: () {},
                        borderRadius: 8,
                        backgroundColor: AppColors.green,
                      ),
                    ],
                  ),
                  sh12,
                ],
              ),
            ),
            sh16,
            Container(
              height: 180,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(AppImages.emergencyFuel),
                  scale: 4,
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Fuel',
                    style: h5.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  sh5,
                  Text(
                    'Rapid Delivery When You Need It Most',
                    style: h6.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  sh8,
                  CustomButton(
                    height: 40,
                    text: 'Order Now',
                    onPressed: () {},
                    gradientColors: AppColors.gradientColor,
                    width: 150,
                  )
                ],
              ),
            ),
            sh16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Choose Your Fuel Type',
                style: h3.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            sh12,
            FuelCard(
              title: 'UNLEADED',
              number: '89',
              buttonText: 'Order Now',
              gradientColors: AppColors.gradientColorBlue,
              onTap: () {
                Get.to(() => OrderFuelView());
              },
            ),
            sh16,
            FuelCard(
              title: 'PREMIUM',
              number: '91',
              buttonText: 'Order Now',
              gradientColors: AppColors.gradientColorGrey,
              onTap: () {
                Get.to(() => OrderFuelView());
              },
            ),
            sh16,
            FuelCard(
              title: 'DIESEL',
              number: '71',
              buttonText: 'Order Now',
              gradientColors: AppColors.gradientColorGreen,
              onTap: () {
                Get.to(() => OrderFuelView());
              },
            ),
            sh16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Services',
                style: h3.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            sh12,
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.silver),
                gradient: LinearGradient(
                  colors: AppColors.gradientColorBlue,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jump Start Car Battery',
                    style: h5.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '\$25',
                    style: h3.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sh12,
                  CustomButton(
                    text: 'Order Now',
                    onPressed: () {
                      Get.to(() => JumpStartCarBatteryView());
                    },
                    gradientColors: AppColors.gradientColor,
                    width: 150,
                    height: 40,
                  ),
                ],
              ),
            ),
            sh16,
            Container(
              height: 250,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(AppImages.discount),
                  scale: 4,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    top: Get.height * 0.2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.blurBack,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join Now for Discounts & No Tips!',
                          style: h5.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        sh8,
                        CustomButton(
                          height: 40,
                          text: 'Join Now',
                          onPressed: () {},
                          gradientColors: AppColors.gradientColor,
                          width: 150,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            sh12,
            CustomRowHeader(title: 'Order History', onTap: () {}),
            FuelOrderCard(
              orderId: '5758',
              orderDate: '10 Dec 2025 at 10:39 AM',
              fuelQuantity: '15 Litres',
              fuelType: 'Premium Fuel',
              price: '65',
              status: 'Fuel Delivered',
            ),
            sh40,
          ],
        ),
      ),
    );
  }
}
