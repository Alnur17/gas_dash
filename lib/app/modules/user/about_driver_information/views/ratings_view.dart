import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gas_dash/app/modules/user/about_driver_information/views/write_review_view.dart';
import 'package:get/get.dart';
import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../controllers/about_driver_information_controller.dart';

class RatingsView extends GetView<AboutDriverInformationController> {
  final String? driverId;

  const RatingsView({super.key, this.driverId});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    final AboutDriverInformationController controller = Get.find<AboutDriverInformationController>();

    // Fetch reviews if not already fetched
    if (driverId != null && controller.reviews.isEmpty) {
      controller.fetchReviews(driverId!);
    }

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
        title: const Text(
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
              Obx(() {
                return Column(
                  children: [
                    Text(
                      controller.averageRating.value.toStringAsFixed(1),
                      style: h2,
                    ),
                    Text(
                      '${controller.reviews.length} Reviews',
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
                                Text('$i★', style: const TextStyle(fontSize: 16)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    minHeight: 6,
                                    borderRadius: BorderRadius.circular(6),
                                    value: controller.getRatingDistribution()[i] ?? 0.0,
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
                );
              }),
              sh30,
              Text(
                'Reviews',
                style: h3,
              ),
              sh12,
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.errorMessage.value.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }
                if (controller.reviews.isEmpty) {
                  return const Center(child: Text('No reviews available'));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.reviews.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final review = controller.reviews[index];
                        return _buildReviewItem(
                          imageUrl: review.driverId?.image ?? AppImages.profileImageTwo,
                          name: review.driverId?.fullname ?? 'Anonymous',
                          rating: review.rating ?? 0.0,
                          review: review.review ?? 'No review provided',
                        );
                      },
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.mainColor,
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: CustomButton(
          text: 'Write Review',
          onPressed: () {
            Get.to(() => WriteReviewView(driverId));
          },
          gradientColors: AppColors.gradientColorGreen,
        ),
      ),
    );
  }

  Widget _buildReviewItem({
    required String imageUrl,
    required String name,
    required double rating,
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
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  AppImages.profileImageTwo,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
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
                        rating: rating,
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