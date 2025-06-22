import 'package:flutter/material.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../../common/widgets/custom_snackbar.dart';
import '../controllers/coupon_controller.dart';
import '../controllers/order_fuel_controller.dart';

class FuelTypeFinalConfirmationView extends StatefulWidget {
  final bool? isEmergency;
  final String vehicleId;
  final bool presetAmount;
  final bool customAmount;
  final double amount;
  final String fuelType;
  final String? scheduleDate;
  final String? scheduleTime;

  const FuelTypeFinalConfirmationView({
    super.key,
    required this.vehicleId,
    required this.presetAmount,
    required this.fuelType,
    required this.amount,
    required this.customAmount,
    this.isEmergency,
    this.scheduleDate,
    this.scheduleTime,
  });

  @override
  State<FuelTypeFinalConfirmationView> createState() =>
      _FuelTypeFinalConfirmationViewState();
}

class _FuelTypeFinalConfirmationViewState
    extends State<FuelTypeFinalConfirmationView> {
  final OrderFuelController controller = Get.put(OrderFuelController());
  final CouponController couponController = Get.put(CouponController());
  final TextEditingController couponTextController = TextEditingController();

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
        automaticallyImplyLeading: false,
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
          child: SingleChildScrollView(
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
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: couponTextController,
                        borderColor: AppColors.orange,
                        preIcon: Image.asset(
                          AppImages.coupon,
                          scale: 4,
                        ),
                        hintText: 'Enter coupon code',
                      ),
                    ),
                    sw5,
                    Obx(() => couponController.isLoading.value
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      borderColor: AppColors.orange,
                      borderRadius: 12,
                      text: 'Apply',
                      onPressed: () {
                        if (couponTextController.text.isNotEmpty) {
                          couponController
                              .checkCoupon(couponTextController.text.trim());
                        } else {
                          kSnackBar(
                            message: 'Please enter a coupon code',
                            bgColor: AppColors.orange,
                          );
                        }
                      },
                      width: 100,
                      textColor: AppColors.orange,
                    )),
                  ],
                ),
                sh20,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location',
                            style: h5.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(controller.currentLocation.value, style: h6),
                        const SizedBox(height: 16),
                        Text('Fuel Type',
                            style: h5.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(widget.fuelType, style: h6),
                        const SizedBox(height: 16),
                        Text('Amount',
                            style: h5.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('${widget.amount} gallons', style: h6),
                        const SizedBox(height: 16),
                        // Text('Delivery Fee',
                        //     style: h5.copyWith(fontWeight: FontWeight.bold)),
                        // const SizedBox(height: 8),
                        sh10,
                        controller.isLoading.value
                            ? CustomLoader(color: AppColors.white)
                            : CustomButton(
                          text: 'Next',
                          onPressed: () {
                            if (widget.isEmergency == true) {
                              controller.createOrder(
                                isEmergency: widget.isEmergency,
                                vehicleId: widget.vehicleId,
                                presetAmount: widget.presetAmount,
                                customAmount: widget.customAmount,
                                amount: widget.amount,
                                fuelType: widget.fuelType,
                                scheduleTime: widget.scheduleTime,
                                scheduleDate: widget.scheduleDate,
                                couponCode: couponTextController.text.trim(),
                              );
                            } else {
                              controller.createOrder(
                                isEmergency: widget.isEmergency,
                                vehicleId: widget.vehicleId,
                                presetAmount: widget.presetAmount,
                                customAmount: widget.customAmount,
                                amount: widget.amount,
                                fuelType: widget.fuelType,
                                couponCode: couponTextController.text.trim(),
                              );
                            }
                          },
                          gradientColors: AppColors.gradientColorGreen,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}