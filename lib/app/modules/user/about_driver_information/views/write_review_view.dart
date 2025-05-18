import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';

import 'package:get/get.dart';

import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../controllers/about_driver_information_controller.dart';

class WriteReviewView extends StatefulWidget {
  const WriteReviewView({super.key});

  @override
  State<WriteReviewView> createState() => _WriteReviewViewState();
}

class _WriteReviewViewState extends State<WriteReviewView> {
  final AboutDriverInformationController aboutDriverInformationController =
      Get.put(AboutDriverInformationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Write Review',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Leave a Review',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Stars
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  return GestureDetector(
                    onTap: () =>
                        aboutDriverInformationController.setRating(starIndex),
                    child: Icon(
                      aboutDriverInformationController.rating.value >= starIndex
                          ? Icons.star
                          : Icons.star_border,
                      color: const Color(0xFFFFB800),
                      size: 40,
                    ),
                  );
                }),
              );
            }),

            const SizedBox(height: 24),

            // Review input
            CustomTextField(
              height: 150,
              hintText: 'write here..',
            ),

            const SizedBox(height: 24),

            // Submit button
            CustomButton(
              text: 'Submit Review',
              onPressed: () {
                _showSubmissionCompletedModal(context);
              },
              gradientColors: AppColors.gradientColorGreen,
            ),
          ],
        ),
      ),
    );
  }

  void _showSubmissionCompletedModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // for rounded corners effect
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circle Icon with green check
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.gradientColorGreen[1].withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppImages.submit,
                    scale: 4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Thank You for Your Review!',
                style: h3.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              sh12,
              Text(
                'Success! Your review has been received and recorded. We appreciate your contribution in helping us improve and providing insights to our community.',
                style: h5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Return to Home',
                onPressed: () {},
                gradientColors: AppColors.gradientColorGreen,
              ),
            ],
          ),
        );
      },
    );
  }
}
