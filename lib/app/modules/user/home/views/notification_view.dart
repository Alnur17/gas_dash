import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/login/views/login_view.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../../driver/driver_home/controllers/driver_notifications_controller.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (LocalStorage.getData(key: AppConstant.accessToken) == null) {
        Get.offAll(() => LoginView());
      }
    });
    super.initState();

  }

  final DriverNotificationsController controller =   Get.put(DriverNotificationsController());

  @override
  Widget build(BuildContext context) {
    // Initialize the controller


    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
            title: Text(
              'Notification',
              style: h2,
            ),
            centerTitle: true,
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
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: controller.notifications.length +
                  (controller.hasMore.value ? 1 : 0),
              itemBuilder: (context, index) {
                // Show loading indicator for pagination
                if (index == controller.notifications.length &&
                    controller.hasMore.value) {
                  controller.fetchNotifications();
                  return const Center(child: CircularProgressIndicator());
                }

                final notification = controller.notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        decoration: ShapeDecoration(
                          shape: const CircleBorder(),
                          color: Colors.blue[50],
                        ),
                        child: Image.asset(
                          AppImages.notification,
                          scale: 4,
                        ),
                      ),
                      sw12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notification.modelType ?? 'No Type',
                              style: h3,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              notification.message ?? 'No Message',
                              style: h4.copyWith(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
