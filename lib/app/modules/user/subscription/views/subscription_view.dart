// import 'package:flutter/material.dart';
// import 'package:gas_dash/common/app_text_style/styles.dart';
// import 'package:gas_dash/common/size_box/custom_sizebox.dart';
// import 'package:get/get.dart';
//
// import '../../../../../common/app_color/app_colors.dart';
// import '../../../../../common/app_images/app_images.dart';
// import '../../../../../common/widgets/custom_circular_container.dart';
// import 'plan_details_view.dart'; // Import the new screen
//
// class SubscriptionView extends StatefulWidget {
//   const SubscriptionView({super.key});
//
//   @override
//   State<SubscriptionView> createState() => _SubscriptionViewState();
// }
//
// class _SubscriptionViewState extends State<SubscriptionView> {
//   int selectedIndex = -1;
//
//   final List<Map<String, dynamic>> plans = [
//     {
//       'title': 'Basic Membership',
//       'price': '15.99 \$',
//       'features': [
//         'Unlocks key features like the ability to skip mandatory tipping.',
//         'Waives delivery fees for up to 4 trips per month.',
//         'Covers 1 vehicle.',
//       ],
//     },
//     {
//       'title': 'Plus Membership',
//       'price': '15.99 \$',
//       'features': [
//         'Includes everything from Tier 1.',
//         'Waives delivery fees for up to 6 trips per month.',
//         '50% off delivery fees after the 6 waived trips.',
//         'Scheduled delivery (users can choose a preferred time slot).',
//         'Fuel price tracking and alerts for low-price windows in the user’s area.',
//         'Covers up to 2 vehicles',
//       ],
//     },
//     {
//       'title': 'Premium Membership',
//       'price': '15.99 \$',
//       'features': [
//         'Includes everything from Tier 2.',
//         'Emergency fuel service at no extra charge (up to 2 times per month).',
//         'Free subscription for one additional family member or household vehicle.',
//         'Exclusive promotions and early access to new features.',
//         'Covers up to 4 vehicles.',
//       ],
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         scrolledUnderElevation: 0,
//         title: Text('Subscription', style: titleStyle),
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 12),
//           child: CustomCircularContainer(
//             imagePath: AppImages.back,
//             onTap: () {
//               Get.back();
//             },
//             padding: 2,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             sh20,
//             Text(
//               'Upgrade plan',
//               style: h2,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Choose a subscription plan to unlock all the\nfunctionality of the application',
//               style: h5,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 30),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: plans.length,
//                 itemBuilder: (context, index) {
//                   bool isSelected = selectedIndex == index;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index;
//                       });
//                       // Navigate to PlanDetailsView with the selected plan's data
//                       Get.to(() => PlanDetailsView(
//                         planTitle: plans[index]['title'],
//                         features: plans[index]['features'],
//                       ));
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 15),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 18, horizontal: 20),
//                       decoration: BoxDecoration(
//                         color:
//                         isSelected ? AppColors.primaryColor : Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           if (!isSelected)
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 15,
//                               offset: const Offset(0, 5),
//                             )
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             plans[index]['title']!,
//                             style: h4.copyWith(
//                               color: isSelected
//                                   ? AppColors.white
//                                   : AppColors.black,
//                               fontWeight: isSelected
//                                   ? FontWeight.bold
//                                   : FontWeight.w400,
//                             ),
//                           ),
//                           Text(
//                             plans[index]['price']!,
//                             style: h2.copyWith(
//                               color:
//                               isSelected ? AppColors.white : AppColors.blue,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/login/views/login_view.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_circular_container.dart';
import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../controllers/subscription_controller.dart';
import 'plan_details_view.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  int selectedIndex = -1;
  final SubscriptionController controller = Get.put(SubscriptionController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (LocalStorage.getData(key: AppConstant.accessToken) == null) {
        Get.offAll(() => LoginView());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        title: Text('Subscription', style: titleStyle),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () => Navigator.pop(context),
            padding: 2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sh20,
            Text('Upgrade plan', style: h2),
            const SizedBox(height: 8),
            Text(
              'Choose a subscription plan to unlock all the\nfunctionality of the application',
              style: h5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value, style: h5));
                }
                if (controller.packages.isEmpty) {
                  return Center(child: Text('No packages available', style: h5));
                }
                return ListView.builder(
                  itemCount: controller.packages.length,
                  itemBuilder: (context, index) {
                    final package = controller.packages[index];
                    bool isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedIndex = index);
                        Get.to(() => PlanDetailsView(package: package));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            if (!isSelected)
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                package.title ?? 'Unknown',
                                style: h4.copyWith(
                                  color: isSelected ? AppColors.white : AppColors.black,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              '\$${package.monthlyPrice?.toStringAsFixed(2) ?? '0.00'}/mo',
                              style: h3.copyWith(
                                color: isSelected ? AppColors.white : AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}