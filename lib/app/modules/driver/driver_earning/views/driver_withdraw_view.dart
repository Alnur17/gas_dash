import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_dash/app/modules/driver/driver_earning/controllers/driver_earning_controller.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/helper/earnings_card.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class DriverWithdrawView extends GetView<DriverEarningController> {
  final String myBalance;
  const DriverWithdrawView(this.myBalance, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        scrolledUnderElevation: 0,
        title: Text(
          'Withdraw',
          style: titleStyle,
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EarningsCard(
                gradientColor: AppColors.gradientColorBlue,
                title: 'Total Balance',
                amount: myBalance,
              ),
              sh12,
              Text(
                'Withdraw Amount',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: '\$1000',
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.]')), // Allow digits and decimal point
                  _AmountInputFormatter(), // Custom formatter for amount
                ],
              ),
              sh12,
              Text(
                'Card Holder Name',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: 'Enter name',
                controller: controller.cardHolderNameController,
              ),
              sh12,
              Text(
                'Card Number',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: '3536 5678 9012 3456',
                controller: controller.cardNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberInputFormatter(),
                ],
              ),
              sh20,
              Obx(() => CustomButton(
                text: controller.isLoading.value ? 'Processing...' : 'Withdraw',
                onPressed: controller.isLoading.value
                    ? () {}
                    : controller.submitWithdrawRequest,
                gradientColors: AppColors.gradientColorGreen,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom input formatter for card number to add spaces every 4 digits
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');
    if (newText.length > 16) {
      newText = newText.substring(0, 16);
    }
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

// Custom input formatter for amount to ensure valid numeric input
class _AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll('\$', '').trim();
    // Allow only valid numeric input (including decimal point)
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(newText)) {
      return oldValue; // Revert to old value if input is invalid
    }
    // Prevent zero or empty input
    if (newText == '0' || newText.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    // Ensure the amount is formatted with a dollar sign
    String formattedText = '\$$newText';
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}