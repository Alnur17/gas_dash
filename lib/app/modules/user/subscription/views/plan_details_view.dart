// import 'package:flutter/material.dart';
// import 'package:gas_dash/common/app_text_style/styles.dart';
// import 'package:gas_dash/common/size_box/custom_sizebox.dart';
// import 'package:gas_dash/common/widgets/custom_background.dart';
// import 'package:gas_dash/common/widgets/custom_button.dart';
// import 'package:get/get.dart';
//
// import '../../../../../common/app_color/app_colors.dart';
// import '../../../../../common/app_images/app_images.dart';
//
// class PlanDetailsView extends StatelessWidget {
//   final String planTitle;
//   final List<String> features;
//
//   const PlanDetailsView({
//     super.key,
//     required this.planTitle,
//     required this.features,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: AppColors.transparent,
//         scrolledUnderElevation: 0,
//         title: Text(planTitle, style: titleStyle.copyWith(color: AppColors.white)),
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 12),
//           child: GestureDetector(
//             onTap: () {
//               Get.back();
//             },
//             child: Image.asset(
//               AppImages.back,
//               scale: 4,
//               color: AppColors.white,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: CustomBackground(
//         backgroundImages: AppImages.subscriptionImage,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               sh100,
//               Text(
//                 planTitle,
//                 style: h2.copyWith(color: AppColors.white,fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               ...features.map((feature) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Row(
//                       children: [
//                         Image.asset(AppImages.subsRight,scale: 4,),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             feature,
//                             style: h3.copyWith(color: AppColors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//               sh30,
//               CustomButton(
//                 text: 'Buy Now',
//                 onPressed: () {},
//                 textColor: AppColors.black,
//                 backgroundColor: AppColors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/subscription/controllers/subscription_controller.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_background.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_loader.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../user/subscription/model/subscription_package_model.dart';

class PlanDetailsView extends StatelessWidget {
  final Datum package;

  const PlanDetailsView({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    final subsController = Get.put(SubscriptionController());
    final features = [
      if (package.freeDeliverylimit != null)
        'Waives delivery fees for up to ${package.freeDeliverylimit} trips per month.',
      if (package.coverVehiclelimit != null)
        'Covers up to ${package.coverVehiclelimit} vehicles.',
      if (package.fiftyPercentOffDeliveryFeeAfterWaivedTrips == true)
        '50% off delivery fees after waived trips.',
      if (package.scheduledDelivery == true)
        'Scheduled delivery (choose preferred time slot).',
      if (package.fuelPriceTrackingAlerts == true)
        'Fuel price tracking and alerts for low-price windows.',
      if (package.noExtraChargeForEmergencyFuelServiceLimit == true)
        'Emergency fuel service at no extra charge (up to ${package.freeDeliverylimit} times per month).',
      if (package.freeSubscriptionAdditionalFamilyMember == true)
        'Free subscription for one additional family member or vehicle.',
      if (package.exclusivePromotionsEarlyAccess == true)
        'Exclusive promotions and early access to new features.',
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        scrolledUnderElevation: 0,
        title: Text(package.title ?? 'Plan',
            style: titleStyle.copyWith(color: AppColors.white)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () => Get.back(),
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
                package.title ?? 'Unknown Plan',
                style: h2.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Image.asset(AppImages.subsRight, scale: 4),
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
              Obx(
                () => subsController.isLoading.value == true
                    ? CustomLoader(color: AppColors.white)
                    : CustomButton(
                        text: 'Buy Now',
                        onPressed: () {
                          subsController.createSubscription(
                              packageId: package.id ?? '');
                        },
                        textColor: AppColors.black,
                        backgroundColor: AppColors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
