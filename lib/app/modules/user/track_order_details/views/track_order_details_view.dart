import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/track_order_details/views/live_tracking_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/timeline_widget.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../controllers/track_order_details_controller.dart';

class TrackOrderDetailsView extends GetView<TrackOrderDetailsController> {
  const TrackOrderDetailsView({super.key});
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
          'Track Order',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID',
                          style: h3,
                        ),
                        Text(
                          '#798796',
                          style: h5,
                        ),
                      ],
                    ),
                    Image.asset(
                      AppImages.copy,
                      scale: 4,
                    ),
                  ],
                ),
              ),
              sh20,
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //     color: AppColors.white,
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text('Time Line',style: h3,),
              //       Text('Time Line',style: h3,),
              //       Text('Time Line',style: h3,),
              //     ],
              //   ),
              // ),
              TimelineWidget(),
              sh20,
              Container(
                //padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Placeholder for the map
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(12),
                          child: Image.asset(
                            AppImages.mapImage,
                            scale: 4,
                            fit: BoxFit.cover,
                          )),
                    ),
                    sh12,
                    Row(
                      children: [
                        Image.asset(
                          AppImages.locationRed,
                          scale: 4,
                        ),
                        sw8,
                        Text(
                          '1401 Thornridge Cir, Shiloh',
                          style: h5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              sh20,
              CustomButton(
                text: 'Tracking Order',
                onPressed: () {
                  Get.to(()=> LiveTrackingView());
                },
                gradientColors:
                AppColors.gradientColorGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
