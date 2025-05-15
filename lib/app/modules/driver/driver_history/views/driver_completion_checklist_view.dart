import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/controllers/driver_completion_checklist_controller.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';

import 'package:get/get.dart';

import '../../../../../common/helper/question_card.dart';

class DriverCompletionChecklistView extends GetView<DriverCompletionChecklistController> {
  const DriverCompletionChecklistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Completion Checklist',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Please confirm the following steps were completed',
            //   style: h3,
            // ),
            // sh20,
            // Text(
            //   'Did you close the gas cap?',
            //   style: h4,
            // ),
            // sh12,
            // Row(
            //   children: [
            //     Image.asset(
            //       AppImages.checkBoxFilled,
            //       scale: 4,
            //     ),
            //     sw8,
            //     Text(
            //       'Yes',
            //       style: h5,
            //     ),
            //   ],
            // ),
            // sh8,
            // Row(
            //   children: [
            //     Image.asset(
            //       AppImages.checkBox,
            //       scale: 4,
            //     ),
            //     sw8,
            //     Text(
            //       'No',
            //       style: h5,
            //     ),
            //   ],
            // ),

            Obx(() {
              return QuestionCard(
                question: 'Did you close the gas cap?',
                option1Selected: controller.option1Selected.value,
                option2Selected: controller.option2Selected.value,
                onOption1Tap: controller.selectOption1,
                onOption2Tap: controller.selectOption2,
              );
            }),
          ],
        ),
      ),
    );
  }
}
