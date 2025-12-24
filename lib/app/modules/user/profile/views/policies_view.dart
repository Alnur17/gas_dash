import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../controllers/conditions_controller.dart';

class PoliciesView extends GetView {
  const PoliciesView({super.key});

  @override
  Widget build(BuildContext context) {
    final ConditionsController controller = Get.put(ConditionsController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        title: Text('Privacy Policy',style: titleStyle,),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator(color: AppColors.textColor,));
            } else if (controller.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.value,
                  style: h4.copyWith(fontSize: 14, color: AppColors.red),
                ),
              );
            } else {
              return Html(
                data: controller.getPrivacyPolicy.value, // Render HTML content
                // style: {
                //   // Optional: Customize HTML rendering styles
                //   "body": Style(
                //     fontSize: FontSize(14),
                //     color: AppColors.black, // Adjust as per your theme
                //   ),
                // },
              );
            }
          }),
        ),
      ),
    );
  }
}
