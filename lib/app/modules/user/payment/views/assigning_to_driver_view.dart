import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/payment/views/payment_success_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';

class AssigningToDriverView extends GetView {
  const AssigningToDriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigning to driver'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            sh30,
            // const Text(
            //   'Assigning to driver',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 20),
            const LinearProgressIndicator(
              value: null,
              minHeight: 10,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Please wait while we are assigning to the driver.',
                style: h3,
                textAlign: TextAlign.center,
              ),
            ),
            sh16,
            CustomButton(
              text: 'Re-Assign',
              onPressed: () {
                Get.offAll(() => PaymentSuccessView());
              },
              gradientColors: AppColors.gradientColorGreen,
            )
          ],
        ),
      ),
    );
  }
}
