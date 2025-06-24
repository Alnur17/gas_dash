import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/emergency_fuel/views/emergency_fuel_view.dart';
import 'package:gas_dash/app/modules/user/home/views/notification_view.dart';
import 'package:gas_dash/app/modules/user/jump_start_car_battery/views/jump_start_car_battery_view.dart';
import 'package:gas_dash/app/modules/user/order_fuel/views/order_fuel_view.dart';
import 'package:gas_dash/app/modules/user/order_history/controllers/order_history_controller.dart';
import 'package:gas_dash/app/modules/user/profile/controllers/profile_controller.dart';
import 'package:gas_dash/app/modules/user/subscription/views/after_subscription_view.dart';
import 'package:gas_dash/app/modules/user/subscription/views/subscription_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/helper/service_card.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/fuel_card.dart';
import '../../../../../common/helper/order_history_card.dart';
import '../../profile/controllers/conditions_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final profileController = Get.put(ProfileController());
  final homeController = Get.put(HomeController());
  final oHController = Get.put(OrderHistoryController());
  final settingsController = Get.put(ConditionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Image.asset(
              AppImages.homeLogo,
              scale: 4,
            ),
            Text(
              'GAS DASH',
              style: h3.copyWith(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => NotificationView());
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: AppColors.silver,
                    ),
                  ),
                ),
                child: Image.asset(
                  AppImages.notification,
                  scale: 4,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await oHController.fetchOrderHistory();
          await profileController.getMyProfile();
          await homeController.getFuelInfo();
          await homeController.fetchServices();
          await settingsController.fetchConditions();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.silver),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.white,
                            backgroundImage: NetworkImage(
                              profileController.myProfileData.value?.image ??
                                  AppImages.profileImageTwo,
                            ),
                          ),
                        ),
                        sw8,
                        Obx(
                          () {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileController
                                          .myProfileData.value?.fullname ??
                                      'Unknown',
                                  style: h3.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Customer',
                                  style: h6.copyWith(
                                    color: AppColors.blueTurquoise,
                                  ),
                                ),
                                Text(
                                  profileController
                                              .myProfileData.value?.title !=
                                          null
                                      ? 'Subscription Type:\n${profileController.myProfileData.value?.title.toString()}'
                                      : 'Subscription Type: Unsubscribe',
                                  style: h6,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    sh12,
                    CustomButton(
                      text: 'Manage Subscription',
                      onPressed: () {
                        Get.to(() =>
                            profileController.myProfileData.value?.title != null
                                ? AfterSubscriptionView()
                                : SubscriptionView());
                      },
                      gradientColors: AppColors.gradientColor,
                    ),
                  ],
                ),
              ),
              sh16,
              Obx(() {
                if (homeController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (homeController.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      homeController.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final data = homeController.fuelInfo.value?.data ?? [];

                if (data.isEmpty) {
                  return const Center(
                    child: Text('No Fuel Price Data Available'),
                  );
                }

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.silver),
                    gradient: LinearGradient(
                      colors: AppColors.gradientColorBlue,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gas prices',
                          style: h3.copyWith(color: AppColors.white)),
                      const SizedBox(height: 8),
                      // Dynamically build price rows
                      for (var fuel in data)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              _getFuelIcon(fuel.fuelName ?? ''),
                              const SizedBox(width: 8),
                              Text(
                                fuel.fuelName?.toUpperCase() ?? '',
                                style: h3.copyWith(
                                  fontSize: 14,
                                  color: AppColors.white,
                                ),
                              ),
                              const Spacer(),
                              CustomButton(
                                height: 40,
                                width: 110,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                text:
                                    (fuel.fuelPrice ?? 0.0).toStringAsFixed(2),
                                onPressed: () {},
                                borderRadius: 8,
                                backgroundColor:
                                    _getFuelColor(fuel.fuelName ?? ''),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }),
              sh16,
            Obx(() =>   Container(
              height: 180,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.silver,
                image: DecorationImage(
                  image: NetworkImage(settingsController.conditionsModel.value.data[0].emergencyFuelBanner.toString()),
                  scale: 4,
                  fit: BoxFit.cover,
                ),
              ),
            ),),
              sh16,
              // Obx(
              //   () => settingsController.isLoading.value == true
              //       ? Center(
              //           child: CircularProgressIndicator(),
              //         )
              //       : Container(
              //           height: 180,
              //           width: double.infinity,
              //           margin: const EdgeInsets.symmetric(horizontal: 20),
              //           padding: const EdgeInsets.symmetric(horizontal: 20),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(20),
              //             image: DecorationImage(
              //               image: NetworkImage(settingsController
              //                   .conditionsModel
              //                   .value
              //                   .data[0]
              //                   .emergencyFuelBanner
              //                   .toString()),
              //               scale: 4,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 'Emergency Fuel',
              //                 style: h5.copyWith(
              //                   fontWeight: FontWeight.w700,
              //                   color: AppColors.white,
              //                 ),
              //               ),
              //               sh5,
              //               Text(
              //                 'Rapid Delivery When You Need It Most',
              //                 style: h6.copyWith(
              //                   fontWeight: FontWeight.w700,
              //                   color: AppColors.white,
              //                 ),
              //               ),
              //               sh8,
              //               CustomButton(
              //                 height: 40,
              //                 text: 'Order Now',
              //                 onPressed: () {
              //                   profileController.myProfileData.value
              //                               ?.noExtraChargeForEmergencyFuelServiceLimit ==
              //                           true
              //                       ? Get.to(() => EmergencyFuelView())
              //                       : Get.to(() => SubscriptionView());
              //                 },
              //                 gradientColors: AppColors.gradientColor,
              //                 width: 150,
              //               ),
              //             ],
              //           ),
              //         ),
              // ),
              sh16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Choose Your Fuel Type',
                  style: h3.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              sh12,
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeController.fuelInfo.value?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final fuelData = homeController.fuelInfo.value?.data[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: index ==
                                  (homeController.fuelInfo.value?.data.length ??
                                          1) -
                                      1
                              ? 0
                              : 16),
                      child: FuelCard(
                        title: fuelData?.fuelName ?? 'Unknown',
                        buttonText: 'Order\nNow',
                        gradientColors: AppColors.gradientColorBlue,
                        onTap: () {
                          Get.to(() => OrderFuelView(
                                fuelName: fuelData?.fuelName,
                                fuelPrice: fuelData?.fuelPrice,
                              ));
                        },
                      ),
                    );
                  },
                ),
              ),
              // FuelCard(
              //   title: 'UNLEADED',
              //   buttonText: 'Order\nNow',
              //   gradientColors: AppColors.gradientColorBlue,
              //   onTap: () {
              //     final price =
              //         homeController.fuelPricesPerGallon['Unleaded'] ?? 0.0;
              //     print(';;;;;;;;;; $price ;;;;;;;;;;;;;;;;;;');
              //     Get.to(() =>
              //         OrderFuelView(
              //           fuelName: 'Unleaded',
              //           //number: '87',
              //           fuelPrice: price,
              //         ));
              //   },
              // ),
              // sh16,
              // FuelCard(
              //   title: 'PREMIUM',
              //   //number: '91',
              //   buttonText: 'Order\nNow',
              //   gradientColors: AppColors.gradientColorGrey,
              //   onTap: () {
              //     final price =
              //         homeController.fuelPricesPerGallon['Premium'] ?? 0.0;
              //     print(';;;;;;;;;; $price ;;;;;;;;;;;;;;;;;;');
              //     Get.to(() =>
              //         OrderFuelView(
              //           fuelName: 'Premium',
              //           // number: '91',
              //           fuelPrice: price,
              //         ));
              //   },
              // ),
              // sh16,
              // FuelCard(
              //   title: 'DIESEL',
              //   //number: '71',
              //   buttonText: 'Order\nNow',
              //   gradientColors: AppColors.gradientColorGreen,
              //   onTap: () {
              //     final price =
              //         homeController.fuelPricesPerGallon['Diesel'] ?? 0.0;
              //     print(';;;;;;;;;; $price ;;;;;;;;;;;;;;;;;;');
              //     Get.to(() =>
              //         OrderFuelView(
              //           fuelName: 'Diesel',
              //           // number: '71',
              //           fuelPrice: price,
              //         ));
              //   },
              // ),
              sh16,
              Container(
                height: 180,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.silver,
                  image: DecorationImage(
                    image: NetworkImage(settingsController
                        .conditionsModel.value.data[0].emergencyFuelBanner
                        .toString()),
                    scale: 4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              sh16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Services',
                  style: h3.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              Obx(() {
                if (homeController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (homeController.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      homeController.errorMessage.value,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }
                if (homeController.services.isEmpty) {
                  return const Center(child: Text('No services found'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: homeController.services.length,
                  itemBuilder: (context, index) {
                    final service = homeController.services[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom:
                            index == homeController.services.length - 1 ? 0 : 8,
                      ),
                      child: ServiceCard(
                        title: service.serviceName ?? 'Unnamed Service',
                        price:
                            '\$${service.price?.toStringAsFixed(2) ?? 'N/A'}',
                        buttonText: 'Order Now',
                        onServiceTap: () {
                          Get.to(
                            () => JumpStartCarBatteryView(
                              title: service.serviceName ?? 'Unnamed Service',
                              price: service.price?.toStringAsFixed(2) ?? 'N/A',
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }),
              Obx(
                () => settingsController.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 250,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(settingsController
                                .conditionsModel.value.data[0].discountBanner
                                .toString()),
                            scale: 4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              top: Get.height * 0.2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.blurBack,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 12,
                              right: 12,
                              child: profileController.myProfileData.value
                                          ?.fiftyPercentOffDeliveryFeeAfterWaivedTrips ==
                                      true
                                  ? Center(
                                      child: Text(
                                        'You\'ve successfully enabled the discount and chosen not to leave a tip. Wishing you a wonderful day!',
                                        style: h5.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Join Now for Discounts & No Tips!',
                                          style: h5.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.white,
                                          ),
                                        ),
                                        sh8,
                                        CustomButton(
                                          height: 40,
                                          text: 'Join Now',
                                          onPressed: () {
                                            Get.to(() => SubscriptionView());
                                          },
                                          gradientColors:
                                              AppColors.gradientColor,
                                          width: 150,
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
              ),
              sh12,
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Order History',
                  style: h3,
                ),
              ),
              //CustomRowHeader(title: 'Order History', onTap: () {}),
              Obx(
                () {
                  // Show loading indicator if data is being fetched
                  if (oHController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Show error message if there's an error
                  if (oHController.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        oHController.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Filter only Pending orders
                  final orders = oHController.orders
                      .where((order) =>
                          order.orderStatus == 'Unassigned' &&
                          order.isPaid == true)
                      .toList();

                  // Show message if no Pending orders are found
                  if (orders.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: const Center(child: Text('No Pending orders found')),
                    );
                  }

                  // Build list of Pending orders
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      debugPrint(
                          'Rendering order status: ${order.orderStatus}');
                      return OrderHistoryCard(
                        emergency: order.emergency ?? false,
                        emergencyImage: AppImages.emergency,
                        orderId: order.id ?? 'N/A',
                        orderDate: order.createdAt?.toString() ?? 'Unknown',
                        fuelQuantity: '${order.amount ?? 0} gallons',
                        fuelType: order.fuelType ?? 'Unknown',
                        price: (order.finalAmountOfPayment ?? 0.0)
                            .toStringAsFixed(2),
                        status: order.orderStatus
                            .toString(), // Since all orders here are Pending
                      );
                    },
                  );
                },
              ),
              sh16,
              Container(
                height: 180,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.silver,
                  image: DecorationImage(
                    image: NetworkImage(settingsController
                        .conditionsModel.value.data[0].emergencyFuelBanner
                        .toString()),
                    scale: 4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              sh40,
            ],
          ),
        ),
      ),
    );
  }

  Widget _getFuelIcon(String fuelName) {
    switch (fuelName.toLowerCase()) {
      case 'unleaded':
        return Image.asset(AppImages.unleaded, scale: 4);
      case 'premium':
        return Image.asset(AppImages.premium, scale: 4);
      case 'diesel':
        return Image.asset(AppImages.diesel, scale: 4);
      default:
        return Image.asset(AppImages.premium, scale: 4);
    }
  }

  Color _getFuelColor(String fuelName) {
    switch (fuelName.toLowerCase()) {
      case 'unleaded':
        return AppColors.blueTurquoise;
      case 'premium':
        return AppColors.grey;
      case 'diesel':
        return AppColors.green;
      default:
        return AppColors.grey;
    }
  }
}
