import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gas_dash/app/modules/user/about_driver_information/views/write_review_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_textfield.dart';

class RatingsView extends GetView {
  const RatingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
        title: Text(
          'Ratings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh16,
              Column(
                children: [
                  Text(
                    '4.8',
                    style: h2,
                  ),
                  Text(
                    '5,922 Reviews',
                    style: h5.copyWith(color: AppColors.grey),
                  ),
                  sh20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        for (int i = 5; i > 0; i--)
                          Row(
                            children: [
                              Text('$i★', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 8),
                              Expanded(
                                child: LinearProgressIndicator(
                                  minHeight: 6,
                                  borderRadius: BorderRadius.circular(6),
                                  value: i == 5
                                      ? 0.8
                                      : i == 4
                                          ? 0.4
                                          : i == 3
                                              ? 0.6
                                              : i == 2
                                                  ? 0.2
                                                  : 0.1,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              sh30,
              Text(
                'Reviews',
                style: h3,
              ),
              sh12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reviews List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return _buildReviewItem(
                        imageUrl: AppImages.profileImageTwo,
                        name: 'Emily Anderson',
                        rating: 5,
                        review:
                            'My fuel was delivered quickly, and the driver, [Driver Name], was very professional and friendly. The process was smooth, and I really appreciated the real-time tracking. Highly recommend this service',
                      );
                    },
                  ),
                  sh50,
                  CustomButton(
                    text: 'Write Review',
                    onPressed: () {
                      Get.to(() => WriteReviewView());
                    },
                    gradientColors: AppColors.gradientColorGreen,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.mainColor,
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: CustomButton(
          text: 'Write Review',
          onPressed: () {},
          gradientColors: AppColors.gradientColorGreen,
        ),
      ),
    );
  }

  Widget _buildReviewItem({
    required String imageUrl,
    required String name,
    required int rating,
    required String review,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reviewer image
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                imageUrl,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Review content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + stars
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: rating.toDouble(),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 16,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          review,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
