import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/emergency_fuel/views/schedule_delivery_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/earnings_card.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';

import 'package:get/get.dart';

import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/helper/location_card.dart';
import '../../../../../common/helper/vehicle_card.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../controllers/order_fuel_controller.dart';

class OrderFuelView extends GetView<OrderFuelController> {
  const OrderFuelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Order Fuel',
          style: titleStyle,
        ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fuel Type',
                style: h3,
              ),
              sh20,
              EarningsCard(
                title: 'Unleaded Fuel',
                amount: '87',
                gradientColor: AppColors.gradientColorBlue,
              ),
              sh20,

              // Insert AmountToggleSection here
              const AmountToggleSection(),
              sh20,

              LocationCard(
                locationText: '1901 Thorn ridge Cir. Shiloh',
                buttonText: 'Change Location',
                onButtonPressed: () {},
              ),
              sh20,
              VehicleCard(
                buttonText: 'Add',
                onButtonPressed: () {},
                imageAssetPath: AppImages.addCar,
              ),
              sh100,
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        color: AppColors.background,
        child: CustomButton(
          text: 'Next',
          onPressed: () {
            //Get.to(()=> FuelTypeFinalConfirmationView());
            Get.to(()=> ScheduleDeliveryView());
          },
          gradientColors: AppColors.gradientColorGreen,
        ),
      ),
    );
  }
}

class AmountToggleSection extends StatefulWidget {
  const AmountToggleSection({super.key});

  @override
  State<AmountToggleSection> createState() => _AmountToggleSectionState();
}

class _AmountToggleSectionState extends State<AmountToggleSection> {
  bool presetEnabled = false;
  bool customEnabled = false;

  String selectedPresetAmount = '20 gallons';

  final presetAmounts = [
    '10 gallons',
    '15 gallons',
    '20 gallons',
    '25 gallons',
  ];

  @override
  Widget build(BuildContext context) {
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
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedPresetAmount,
            isExpanded: true,
            icon:
                const Icon(Icons.keyboard_arrow_down, color: Color(0xFF9CA3AF)),
            style: inputTextStyle,
            items: presetAmounts.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: inputTextStyle),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  selectedPresetAmount = val;
                });
              }
            },
          ),
        ),
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
        decoration: inputDecoration('20 gallons'),
        style: inputTextStyle,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preset Amounts Toggle
        buildToggle(
          label: 'Preset Amounts',
          enabled: presetEnabled,
          onTap: () => setState(() => presetEnabled = !presetEnabled),
        ),
        const SizedBox(height: 8),
        if (presetEnabled) ...[
          Text('Amounts', style: labelStyle),
          const SizedBox(height: 6),
          buildAmountDropdown(),
          const SizedBox(height: 12),
          Text('Price', style: labelStyle),
          const SizedBox(height: 6),
          buildReadOnlyPrice('\$21.00'),
        ],

        const SizedBox(height: 24),

        // Custom Amounts Toggle
        buildToggle(
          label: 'Custom Amounts',
          enabled: customEnabled,
          onTap: () => setState(() => customEnabled = !customEnabled),
        ),
        const SizedBox(height: 8),
        if (customEnabled) ...[
          Text('Amounts', style: labelStyle),
          const SizedBox(height: 6),
          buildAmountInput(),
          const SizedBox(height: 12),
          Text('Price', style: labelStyle),
          const SizedBox(height: 6),
          buildReadOnlyPrice('\$21.00'),
        ],
      ],
    );
  }
}
