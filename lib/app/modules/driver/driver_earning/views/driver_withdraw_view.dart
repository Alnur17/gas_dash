import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/helper/earnings_card.dart';

class DriverWithdrawView extends GetView {
  const DriverWithdrawView({super.key});

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
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EarningsCard(
                gradientColor: AppColors.gradientColorBlue,
                title: 'Total Balance',
                amount: '1000',
              ),
              sh12,
              Text(
                'Amount',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: '\$1000',
              ),
              sh12,
              Text(
                'Card Holder Name',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: 'TANZIDA',
              ),
              sh12,
              Text(
                'Card Number',
                style: h5,
              ),
              sh8,
              CustomTextField(
                hintText: '3536 3532 1235 0987',
              ),
              sh20,
              CustomButton(
                text: 'Withdraw',
                onPressed: () {},
                gradientColors: AppColors.gradientColorGreen,
              ),
            ],
          ),
        ));
  }
}
