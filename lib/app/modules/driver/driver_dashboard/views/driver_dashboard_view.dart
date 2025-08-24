import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_earning/views/driver_earning_view.dart';
import 'package:gas_dash/app/modules/driver/driver_history/views/driver_history_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';

import 'package:get/get.dart';

import '../../../../../common/app_text_style/styles.dart';
import '../../../user/message/views/message_view.dart';
import '../../driver_home/views/driver_home_view.dart';
import '../../driver_profile/views/driver_profile_view.dart';
import '../controllers/driver_dashboard_controller.dart';

class DriverDashboardView extends StatefulWidget {
  const DriverDashboardView({super.key});

  @override
  State<DriverDashboardView> createState() => _DriverDashboardViewState();
}

class _DriverDashboardViewState extends State<DriverDashboardView> {
  final DriverDashboardController dashboardController =
      Get.put(DriverDashboardController());

  static final List<Widget> _views = [
    const DriverHomeView(),
    const DriverHistoryView(),
    const DriverEarningView(),
    const MessageView(),
    DriverProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _views[dashboardController.selectedIndex.value]),
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
                        'History',
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
                        dashboardController.selectedIndex.value == 2
                            ? AppImages.earningFilled
                            : AppImages.earning,
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
                        'Earning',
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
                            ? AppImages.messagesFilled
                            : AppImages.messages,
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
                        dashboardController.selectedIndex.value == 4
                            ? AppImages.personFilled
                            : AppImages.person,
                        width: 24,
                        height: 24,
                        scale: 4,
                      ),
                      onPressed: () {
                        dashboardController.changeTabIndex(4);
                      },
                    ),
                    if (dashboardController.selectedIndex.value == 4)
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
