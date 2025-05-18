import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class NotificationView extends GetView {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: 30,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                  const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                  child: Row(
                    children: [

                      Container(
                        width: 48,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
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
                              'Order Assigned',
                              style: h3,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              'Confirm you accepted a new order',
                              style: h4.copyWith(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
