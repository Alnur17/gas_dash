import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/payment/controllers/payment_controller.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../order_fuel/controllers/order_fuel_controller.dart';
import '../../order_fuel/model/final_confirmation_model.dart';

class FinalConfirmationView extends GetView<OrderFuelController> {
  final String? orderId;

  const FinalConfirmationView({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final OrderFuelController controller = Get.find<OrderFuelController>();
    final PaymentController paymentController = Get.put(PaymentController());

    // Fetch order details if orderId is provided
    Future<FinalConfirmationModel?> orderFuture = orderId != null
        ? controller.fuelTypeFinalConfirmation(orderId!)
        : Future.value(null);

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
        title: Text('Final Confirmation', style: titleStyle),
        centerTitle: true,
      ),
      body: Obx(() {
        // Show loading indicator while fetching location
        if (controller.currentLocation.value == 'Fetching location...') {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh20,
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder<FinalConfirmationModel?>(
                    future: orderFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || snapshot.data == null || snapshot.data!.data == null) {
                        return Text(
                          snapshot.hasError ? 'Error: ${snapshot.error}' : 'No order details found',
                          style: h6,
                        );
                      }

                      final orderData = snapshot.data!.data!;
                      final vehicle = controller.confirmedVehicle.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Location',
                              style: h5.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              '${controller.currentLocation.value}, ${orderData.zipCode ?? 'N/A'}',
                              style: h6),
                          const SizedBox(height: 16),
                          Text('Vehicle',
                              style: h5.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              vehicle != null
                                  ? '${vehicle['year']} ${vehicle['make']} ${vehicle['model']}, ~${vehicle['fuelLevel']}% fuel'
                                  : 'N/A',
                              style: h6),
                          const SizedBox(height: 16),
                          Text('Delivery Fee',
                              style: h5.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              '\$${orderData.deliveryFee?.toStringAsFixed(2)}',
                              style: h6),
                          const SizedBox(height: 16),
                          Text('Service Fee',
                              style: h5.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              '\$${orderData.servicesFee?.toStringAsFixed(2) ?? '0.00'}',
                              style: h6),
                        ],
                      );
                    },
                  ),
                ),
              ),
              sh30,
              CustomButton(
                text: 'Next',
                onPressed: () {
                  paymentController.createPaymentSession(orderId: orderId!);
                },
                gradientColors: AppColors.gradientColorGreen,
              ),
            ],
          ),
        );
      }),
    );
  }
}