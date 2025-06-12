import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/helper/location_card.dart';
import '../../../../../common/helper/vehicle_card.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../controllers/order_fuel_controller.dart';

class OrderFuelView extends GetView<OrderFuelController> {
  final String? fuelName;
  final double? fuelPrice;

  OrderFuelView({
    super.key,
    this.fuelName,
    this.fuelPrice,
  });

  final OrderFuelController orderFuelController = Get.put(OrderFuelController());

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
                Text('Make', style: h5),
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
                Text('Model', style: h5),
                CustomTextField(
                  hintText: 'Enter vehicle model',
                  controller: orderFuelController.modelController,
                  onChange: (value) {
                    orderFuelController.selectedModel.value = value;
                  },
                ),
                const SizedBox(height: 12),
                Text('Year', style: h5),
                CustomTextField(
                  hintText: 'Enter vehicle year',
                  controller: orderFuelController.yearController,
                  onChange: (value) {
                    orderFuelController.selectedYear.value = value;
                  },
                ),
                const SizedBox(height: 12),
                Text('Fuel Level', style: h5),
                CustomTextField(
                  hintText: 'e.g. 20%',
                  controller: orderFuelController.fuelLevelController,
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
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text('Order Fuel', style: titleStyle),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fuel Type', style: h3),
              sh20,
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(AppImages.oilLoader),
                    alignment: Alignment.centerRight,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${fuelPrice ?? 0.0}',
                            style: h1.copyWith(color: AppColors.white),
                          ),
                          Text(
                            '$fuelName / gallons',
                            style: h2.copyWith(
                              fontSize: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              sh20,
              AmountToggleSection(fuelPrice: fuelPrice),
              sh20,
              Obx(
                    () => LocationCard(
                  locationText: orderFuelController.currentLocation.value,
                  buttonText: 'Change Location',
                  onButtonPressed: () {
                    orderFuelController.fetchCurrentLocation();
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
              sh100,
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        color: AppColors.background,
        child: CustomButton(
          text: 'Next',
          onPressed: () {
            if (orderFuelController.confirmedVehicle.value == null) {
              Get.snackbar('Error', 'Please select or add a vehicle',
                  snackPosition: SnackPosition.BOTTOM);
              return;
            }
            if (orderFuelController.latitude.value == null ||
                orderFuelController.longitude.value == null) {
              Get.snackbar('Error', 'Location not available',
                  snackPosition: SnackPosition.BOTTOM);
              return;
            }

            double amount = 0.0;
            if (orderFuelController.presetEnabled.value) {
              amount = orderFuelController
                  .parseGallons(orderFuelController.selectedPresetAmount.value);
            } else if (orderFuelController.customEnabled.value) {
              amount = orderFuelController.parseGallons(
                  orderFuelController.customAmountController.text.isEmpty
                      ? '0 gallons'
                      : '${orderFuelController.customAmountController.text} gallons');
            } else {
              Get.snackbar('Error', 'Please select an amount',
                  snackPosition: SnackPosition.BOTTOM);
              return;
            }

            orderFuelController.createOrder(
              vehicleId: orderFuelController.selectedVehicle.value?.id ?? '',
              presetAmount: orderFuelController.presetEnabled.value,
              customAmount: orderFuelController.customEnabled.value,
              amount: amount,
              fuelType: fuelName ?? 'Premium',
            );
          },
          gradientColors: AppColors.gradientColorGreen,
        ),
      ),
    );
  }
}

class AmountToggleSection extends StatelessWidget {
  final double? fuelPrice;

  const AmountToggleSection({super.key, this.fuelPrice});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderFuelController>();

    const labelStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Color(0xFF263238),
    );

    const inputTextStyle = TextStyle(
      fontSize: 14,
      color: Color(0xFF9CA3AF),
    );

    InputDecoration inputDecoration(String hint) => InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFD1D5DB),
        fontSize: 14,
      ),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: Color(0xFF22D3EE)),
      ),
    );

    Widget buildToggle({
      required String label,
      required bool enabled,
      required VoidCallback onTap,
    }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              width: 48,
              height: 24,
              child: Image.asset(
                enabled ? AppImages.toggleOn : AppImages.toggleOff,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      );
    }

    Widget buildAmountDropdown() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Obx(() => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.selectedPresetAmount.value,
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down,
                color: Color(0xFF9CA3AF)),
            style: inputTextStyle,
            items: controller.presetAmounts.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: inputTextStyle),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                controller.selectedPresetAmount.value = val;
              }
            },
          ),
        )),
      );
    }

    Widget buildReadOnlyPrice(String price) {
      return TextField(
        readOnly: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: price,
          hintStyle: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 14),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 14),
        enabled: false,
      );
    }

    Widget buildAmountInput() {
      return TextField(
        controller: controller.customAmountController,
        decoration: inputDecoration('Enter gallons (e.g., 20)'),
        style: inputTextStyle,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          controller.customAmountText.value = value;
        },
      );
    }

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildToggle(
          label: 'Preset Amounts',
          enabled: controller.presetEnabled.value,
          onTap: controller.togglePreset,
        ),
        const SizedBox(height: 8),
        if (controller.presetEnabled.value) ...[
          Text('Amounts', style: labelStyle),
          const SizedBox(height: 6),
          buildAmountDropdown(),
          const SizedBox(height: 12),
          Text('Price', style: labelStyle),
          const SizedBox(height: 6),
          buildReadOnlyPrice(
            controller.calculatePrice(
              controller.parseGallons(controller.selectedPresetAmount.value),
              fuelPrice,
            ),
          ),
        ],
        const SizedBox(height: 24),
        buildToggle(
          label: 'Custom Amounts',
          enabled: controller.customEnabled.value,
          onTap: controller.toggleCustom,
        ),
        const SizedBox(height: 8),
        if (controller.customEnabled.value) ...[
          Text('Amounts', style: labelStyle),
          const SizedBox(height: 6),
          buildAmountInput(),
          const SizedBox(height: 12),
          Text('Price', style: labelStyle),
          const SizedBox(height: 6),
          buildReadOnlyPrice(
            controller.calculatePrice(
              controller.parseGallons(
                controller.customAmountController.text.isEmpty
                    ? '0 gallons'
                    : '${controller.customAmountController.text} gallons',
              ),
              fuelPrice,
            ),
          ),
        ],
      ],
    ));
  }
}