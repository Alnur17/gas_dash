import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class CancelOrderView extends GetView {
  const CancelOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Cancel Order',
          style: titleStyle,
        ),
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            sh16,
            Expanded(
              child: ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: index == 25 -1 ? 80 : 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.checkBoxFilledSquare,
                            scale: 4,
                          ),
                          sw12,
                          Text(
                            'The price is not reasonable',
                            style: h5,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: AppColors.mainColor,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: CustomButton(
          text: 'Submit',
          onPressed: () {},
          gradientColors: AppColors.gradientColorGreen,
        ),
      ),
    );
  }
}
