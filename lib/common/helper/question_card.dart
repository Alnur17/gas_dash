import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_images/app_images.dart';

import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String option1;
  final String option2;
  final bool option1Selected;
  final bool option2Selected;
  final VoidCallback? onOption1Tap;
  final VoidCallback? onOption2Tap;

  const QuestionCard({
    super.key,
    required this.question,
    this.option1 = 'Yes',
    this.option2 = 'No',
    this.option1Selected = false,
    this.option2Selected = false,
    this.onOption1Tap,
    this.onOption2Tap,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please confirm the following steps were completed',
          style: h3,
        ),
        sh20,
        Text(
          question,
          style: h4,
        ),
        sh12,
        GestureDetector(
          onTap: onOption1Tap,
          child: Row(
            children: [
              Image.asset(
                option1Selected
                    ? AppImages.checkBoxFilled
                    : AppImages.checkBox,
                scale: 4,
              ),
              sw8,
              Text(
                option1,
                style: h5,
              ),
            ],
          ),
        ),
        sh8,
        GestureDetector(
          onTap: onOption2Tap,
          child: Row(
            children: [
              Image.asset(
                option2Selected
                    ? AppImages.checkBoxFilled
                    : AppImages.checkBox,
                scale: 4,
              ),
              sw8,
              Text(
                option2,
                style: h5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
