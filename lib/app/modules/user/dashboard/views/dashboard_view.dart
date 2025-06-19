import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/emergency_fuel/views/emergency_fuel_view.dart';
import 'package:gas_dash/app/modules/user/message/views/message_view.dart';
import 'package:gas_dash/app/modules/user/order_history/views/order_history_view.dart';
import 'package:gas_dash/app/modules/user/profile/views/profile_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';

import 'package:get/get.dart';

import '../../../../../common/app_text_style/styles.dart';
import '../../home/views/home_view.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../subscription/views/subscription_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardController dashboardController =
      Get.put(DashboardController());
  final profileController = Get.put(ProfileController());

  static final List<Widget> _views = [
    HomeView(),
    OrderHistoryView(),
    MessageView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _views[dashboardController.selectedIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          profileController.myProfileData.value
              ?.noExtraChargeForEmergencyFuelServiceLimit ==
              true
              ? Get.to(() => EmergencyFuelView())
              : Get.to(() => SubscriptionView());
        },
        backgroundColor: AppColors.textColor,
        shape: const CircleBorder(),
        child: Image.asset(AppImages.addFloating,scale: 4,),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.mainColor,
        padding: EdgeInsets.zero,
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        dashboardController.selectedIndex.value == 0
                            ? AppImages.homeFilled
                            : AppImages.home,
                        width: 24,
                        height: 24,
                        scale: 4,
                      ),
                      onPressed: () {
                        dashboardController.changeTabIndex(0);
                      },
                    ),
                    if (dashboardController.selectedIndex.value == 0)
                      Text(
                        'Home',
                        style: h6.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        dashboardController.selectedIndex.value == 1
                            ? AppImages.bookFilled
                            : AppImages.book,
                        width: 24,
                        height: 24,
                        scale: 4,
                      ),
                      onPressed: () {
                        dashboardController.changeTabIndex(1);
                      },
                    ),
                    if (dashboardController.selectedIndex.value == 1)
                      Text(
                        'Order History',
                        style: h6.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        dashboardController.selectedIndex.value == 2
                            ? AppImages.messagesFilled
                            : AppImages.messages,
                        width: 24,
                        height: 24,
                        scale: 4,
                      ),
                      onPressed: () {
                        dashboardController.changeTabIndex(2);
                      },
                    ),
                    if (dashboardController.selectedIndex.value == 2)
                      Text(
                        'Message',
                        style: h6.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        dashboardController.selectedIndex.value == 3
                            ? AppImages.personFilled
                            : AppImages.person,
                        width: 24,
                        height: 24,
                        scale: 4,
                      ),
                      onPressed: () {
                        dashboardController.changeTabIndex(3);
                      },
                    ),
                    if (dashboardController.selectedIndex.value == 3)
                      Text(
                        'Profile',
                        style: h6.copyWith(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
