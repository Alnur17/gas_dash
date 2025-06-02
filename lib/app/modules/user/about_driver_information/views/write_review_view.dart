import 'package:flutter/material.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import '../controllers/about_driver_information_controller.dart';

class WriteReviewView extends StatefulWidget {
  final String? driverId;

  const WriteReviewView( this.driverId,{super.key,});

  @override
  State<WriteReviewView> createState() => _WriteReviewViewState();
}

class _WriteReviewViewState extends State<WriteReviewView> {
  final AboutDriverInformationController controller =
  Get.find<AboutDriverInformationController>();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Sync text field with controller's reviewText
    textController.text = controller.reviewText.value;
    textController.addListener(() {
      controller.setReviewText(textController.text);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // Check if submission is allowed
  bool get canSubmit => controller.canSubmit && widget.driverId != null;

  // Handle review submission
  Future<void> _handleSubmitReview() async {
    if (widget.driverId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Driver ID is required'),
          backgroundColor: AppColors.orange,
        ),
      );
      return;
    }

    final success = await controller.submitReview(widget.driverId);
    if (success) {
      _showSubmissionCompletedModal(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(controller.errorMessage.value),
          backgroundColor: AppColors.orange,
        ),
      );
    }
  }

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
      body: Obx(() {
        return Stack(
          children: [
            Padding(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      return GestureDetector(
                        onTap: () => controller.setRating(starIndex),
                        child: Icon(
                          controller.rating.value >= starIndex
                              ? Icons.star
                              : Icons.star_border,
                          color: const Color(0xFFFFB800),
                          size: 40,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  // Review input
                  CustomTextField(
                    controller: textController,
                    height: 150,
                    hintText: 'Write here...',
                  ),
                  const SizedBox(height: 24),
                  // Submit button
                  CustomButton(
                    text: 'Submit Review',
                    onPressed: canSubmit ? () => _handleSubmitReview() : () {},
                    gradientColors: AppColors.gradientColorGreen,
                  ),
                ],
              ),
            ),
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      }),
    );
  }

  void _showSubmissionCompletedModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
                text: 'Return to Reviews',
                onPressed: () {
                  Get.back(); // Close modal
                  Get.back(); // Return to RatingsView or AboutDriverInformationView
                },
                gradientColors: AppColors.gradientColorGreen,
              ),
            ],
          ),
        );
      },
    );
  }
}