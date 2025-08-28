import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/payment/controllers/payment_controller.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../order_fuel/controllers/order_fuel_controller.dart';

class FinalConfirmationView extends StatefulWidget {
  final String? orderId;
  final String address;

  const FinalConfirmationView({super.key, this.orderId, required this.address});

  @override
  State<FinalConfirmationView> createState() => _FinalConfirmationViewState();
}

class _FinalConfirmationViewState extends State<FinalConfirmationView> {
  final OrderFuelController controller = Get.put(OrderFuelController());
  final PaymentController paymentController = Get.put(PaymentController());

  final TextEditingController couponTextController = TextEditingController();

  @override
  void initState() {
    if (widget.orderId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fuelTypeFinalConfirmation(widget.orderId!);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    couponTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back, scale: 4),
        ),
        title: Text('Final Confirmation', style: titleStyle),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.currentLocation.value == 'Fetching location...') {
          return const Center(child: CircularProgressIndicator(color: AppColors.textColor,));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh20,
              Text(
                'Discount Coupon',
                style: h5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              sh8,
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
                  child: Obx(
                    () {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.finalConfirmation.value == null ||
                          controller.finalConfirmation.value!.data == null) {
                        return Text(
                          'No order details found',
                          style: h6,
                        );
                      }

                      final orderData =
                          controller.finalConfirmation.value!.data!;
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
                                  ? '${vehicle['year']} ${vehicle['make']} ${vehicle['model']}'
                                  : 'N/A',
                              style: h6),
                          const SizedBox(height: 16),
                          Text('Delivery Fee',
                              style: h5.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('\$${orderData.deliveryFee?.toStringAsFixed(2)}',
                              style: h6),
                          const SizedBox(height: 16),
                          Text('Service Fee',
                              style: h5.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              '\$${orderData.servicesFee?.toStringAsFixed(2) ?? '0.00'}',
                              style: h6),
                          // Text(
                          //   couponController.couponModel.value?.data != null
                          //       ? '\$${orderData.servicesFee?.toStringAsFixed(2) ?? '0.00'} - \$${couponController.couponModel.value?.data?.discount?.toStringAsFixed(2) ?? '0.00'}'
                          //       : '\$${orderData.servicesFee?.toStringAsFixed(2) ?? '0.00'}',
                          //   style: h6.copyWith(
                          //       color: couponController.couponModel.value?.data != null
                          //           ? AppColors.green
                          //           : AppColors.black,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              sh30,
              Obx(
                () => paymentController.isLoading.value == true
                    ? CustomLoader(color: AppColors.white)
                    : CustomButton(
                        text: 'Next',
                        onPressed: () {
                          paymentController.createPaymentSession(
                              orderId: widget.orderId!);
                        },
                        gradientColors: AppColors.gradientColorGreen,
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
