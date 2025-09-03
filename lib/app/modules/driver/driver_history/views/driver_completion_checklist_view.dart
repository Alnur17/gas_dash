import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_history/controllers/driver_completion_checklist_controller.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_circular_container.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class DriverCompletionChecklistView
    extends GetView<DriverCompletionChecklistController> {
  final String deliveryId;
  final String orderId;

  const DriverCompletionChecklistView(this.deliveryId, this.orderId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverCompletionChecklistController());
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
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
          'Completion Checklist',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please confirm the following steps were completed',
              style: h3,
            ),
            sh20,
            Expanded(
              child: ListView.builder(
                itemCount: controller.questions.length,
                itemBuilder: (context, index) {
                  final question = controller.questions[index];
                  final textController =
                  TextEditingController(text: controller.explanations[question.id!] ?? '');
                  return Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.text ?? '',
                        style: h3,
                      ),
                      sh12,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => controller.toggleAnswer(
                                question.id!, true),
                            child: Image.asset(
                              controller.answers[question.id!] == true
                                  ? AppImages.checkBoxFilled
                                  : AppImages.checkBoxBig,
                              scale: 4,
                            ),
                          ),
                          sw8,
                          Text(
                            'Yes',
                            style: h5,
                          ),
                        ],
                      ),
                      sh8,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => controller.toggleAnswer(
                                question.id!, false),
                            child: Image.asset(
                              controller.answers[question.id!] ==
                                  false
                                  ? AppImages.checkBoxFilled
                                  : AppImages.checkBoxBig,
                              scale: 4,
                            ),
                          ),
                          sw8,
                          Text(
                            'No',
                            style: h5,
                          ),
                        ],
                      ),
                      sh8,
                      if (controller.answers[question.id!] == false)
                        CustomTextField(
                          hintText: 'Enter reason',
                          onChange: (value) => controller
                              .updateExplanation(question.id!, value),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0),
                        //   child: TextField(
                        //     controller: textController,
                        //     decoration: InputDecoration(
                        //       hintText: 'Enter reason',
                        //       border: OutlineInputBorder(),
                        //     ),
                        //     onChanged: (value) => controller
                        //         .updateExplanation(question.id!, value),
                        //   ),
                        // ),
                      sh20,
                    ],
                  ));
                },
              ),
            ),
            CustomButton(
              text: 'Next',
              onPressed: () {
                controller.submitAnswers(deliveryId, orderId);
              },
              gradientColors: AppColors.gradientColorGreen,
            ),
            sh20,
          ],
        ),
      )),
    );
  }
}
