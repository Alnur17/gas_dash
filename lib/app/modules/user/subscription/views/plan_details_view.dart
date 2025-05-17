import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_background.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';

class PlanDetailsView extends StatelessWidget {
  final String planTitle;
  final List<String> features;

  const PlanDetailsView({
    super.key,
    required this.planTitle,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        scrolledUnderElevation: 0,
        title: Text(planTitle, style: titleStyle.copyWith(color: AppColors.white)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.back,
              scale: 4,
              color: AppColors.white,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: CustomBackground(
        backgroundImages: AppImages.subscriptionImage,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh100,
              Text(
                planTitle,
                style: h2.copyWith(color: AppColors.white,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Image.asset(AppImages.subsRight,scale: 4,),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            feature,
                            style: h3.copyWith(color: AppColors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
              sh30,
              CustomButton(
                text: 'Buy Now',
                onPressed: () {},
                textColor: AppColors.black,
                backgroundColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
