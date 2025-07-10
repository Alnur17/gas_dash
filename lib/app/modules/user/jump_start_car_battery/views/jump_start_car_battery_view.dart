import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/earnings_card.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_loader.dart';

import 'package:get/get.dart';

import '../../../../../common/helper/location_card.dart';
import '../../../../../common/helper/vehicle_card.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../../order_fuel/controllers/order_fuel_controller.dart';
import '../../order_fuel/views/map_picker_view.dart';

class JumpStartCarBatteryView extends StatefulWidget {
  final String? title;
  final String? price;

  const JumpStartCarBatteryView({
    super.key,
    this.title,
    this.price,
  });

  @override
  State<JumpStartCarBatteryView> createState() =>
      _JumpStartCarBatteryViewState();
}

class _JumpStartCarBatteryViewState extends State<JumpStartCarBatteryView> {
  final OrderFuelController orderFuelController =
      Get.put(OrderFuelController());

  @override
  void initState() {
    super.initState();
    orderFuelController.fetchCurrentLocation();
  }

  void _showAddVehicleDialog() {
    orderFuelController.resetForm();

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Vehicle Details',
                    style: h3.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),

                // Make TextField3256
                Text(
                  'Make',
                  style: h5,
                ),
                CustomTextField(
                  hintText: 'Ford',
                  controller: orderFuelController.makeController,
                  onChange: (value) {
                    orderFuelController.selectedMake.value = value;
                    orderFuelController.selectedModel.value = null;
                    orderFuelController.modelController.clear();
                  },
                ),
                const SizedBox(height: 12),

                // Model TextField
                Text(
                  'Model',
                  style: h5,
                ),
                CustomTextField(
                  hintText: 'Enter vehicle model',
                  controller: orderFuelController.modelController,
                  onChange: (value) {
                    orderFuelController.selectedModel.value = value;
                  },
                ),
                const SizedBox(height: 12),

                // Year TextField
                Text(
                  'Year',
                  style: h5,
                ),
                CustomTextField(
                  hintText: 'Enter vehicle year',
                  controller: orderFuelController.yearController,
                  onChange: (value) {
                    orderFuelController.selectedYear.value = value;
                  },
                ),
                const SizedBox(height: 12),
                Text('Color', style: h5),
                CustomTextField(
                  hintText: 'Enter the color of your car',
                  controller: orderFuelController.colorTEController,
                ),
                const SizedBox(height: 12),
                Text('License Plate Number', style: h5),
                CustomTextField(
                  hintText: 'Enter the license number',
                  controller:
                  orderFuelController.licensePlateNumberTEController,
                ),
                const SizedBox(height: 20),

                CustomButton(
                  text: 'Confirm',
                  onPressed: () {
                    orderFuelController.confirmVehicle();
                  },
                  gradientColors: AppColors.gradientColorGreen,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

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
          'Jump Start Car Battery',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sh16,
              EarningsCard(
                title: widget.title ?? 'N/A',
                amount: widget.price ?? 'N/A',
                gradientColor: AppColors.gradientColorBlue,
              ),
              sh20,
              Obx(
                () => LocationCard(
                  locationText: orderFuelController.currentLocation.value,
                  buttonText: 'Change Location',
                  onButtonPressed: () {
                    Get.to(() => const MapPickerView());
                  },
                ),
              ),
              sh20,
              VehicleCard(
                onAddCarTap: () {
                  _showAddVehicleDialog();
                },
                onSelectCarTap: () {
                  orderFuelController.showVehicleSelectionDialog();
                },
                imageAssetPath: AppImages.addCar,
              ),
              sh20,
              Obx(
                () => orderFuelController.isLoading.value
                    ? CustomLoader(color: AppColors.white)
                    : CustomButton(
                        text: 'Next',
                        onPressed: () {
                          orderFuelController.createOrderForServices(
                              vehicleId: orderFuelController
                                      .selectedVehicle.value?.id
                                      .toString() ??
                                  '',
                              orderType: 'Battery');
                        },
                        gradientColors: AppColors.gradientColorGreen,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
