import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gas_dash/app/modules/user/about_driver_information/views/ratings_view.dart';
import 'package:gas_dash/app/modules/user/about_driver_information/views/write_review_view.dart';
import 'package:gas_dash/app/modules/user/dashboard/views/dashboard_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_row_header.dart';
import 'package:get/get.dart';
import '../../../../../common/helper/socket_service.dart';
import '../../message/controllers/message_send_controller.dart';
import '../../order_history/model/order_history_model.dart';
import '../controllers/about_driver_information_controller.dart';

class AboutDriverInformationView
    extends StatelessWidget {

  final DriverId? driver;

   AboutDriverInformationView({super.key,  this.driver});

  final profileImage =
      'https://images.unsplash.com/photo-1527980965255-d3b416303d12?auto=format&fit=crop&w=800&q=80';

  final MessageSendController messageSendController = Get.put(MessageSendController());
  final SocketService socketService = Get.put(SocketService());

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    return Scaffold(
      backgroundColor: const Color(0xfff5f7f8),
      body: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Stack(
                children: [
                  Image.network(
                    profileImage,
                    // Replace with controller.reviews[0].driverId?.image if available
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.network(
                      profileImage,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                            shape: CircleBorder(), color: AppColors.white),
                        child: Image.asset(
                          AppImages.back,
                          scale: 4,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 32,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver!.fullname.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          driver!.role.toString(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                  final data = {
                                    'receiver': driver!.id.toString(),
                                    'text': "Hello",
                                  };
                                  try {
                                    print('Sending message with data: $data');
                                    final ack = await socketService.emitWithAck('send-message', data);
                                    print('Acknowledgment received: $ack, type: ${ack.runtimeType}');
                                    print("send dddd");
                                  Get.to(() => DashboardView());
                                    if (ack == true) {
                                      messageSendController.messageTextController.clear();
                                    } else {
                                      print('Acknowledgment failed or invalid: $ack');
                                    }
                                  } catch (e) {
                                    print('Error sending message: $e');
                                  }

                              },
                              child: _buildIconLabel(
                                icon: AppImages.chatTwo,
                                label: '',
                                backgroundColor: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildIconLabel(
                              icon: AppImages.work,
                              label:
                              '${driver!.experience}+ Experience',
                              backgroundColor:
                              Colors.black.withOpacity(0.4),
                            ),
                            const SizedBox(width: 8),
                            _buildIconLabel(
                              icon: AppImages.star,
                              label: driver!.averageRating.toString(),
                              backgroundColor:
                              Colors.black.withOpacity(0.4),
                            ),
                            const SizedBox(width: 8),
                            _buildIconLabel(
                              icon: AppImages.callSmall,
                              label: '',
                              backgroundColor: Colors.black.withOpacity(0.4),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            sh20,
            // CustomRowHeader(
            //   title: 'Reviews',
            //   onTap: () {
            //     Get.to(() => RatingsView());
            //   },
            // ),
            // Reviews & List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reviews List
                    Expanded(
                      child:  driver!.reviews.isEmpty? Text("Empty review") :   Expanded(child: ListView.separated(
                        itemCount: driver!.reviews.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final review = driver!.reviews[index];
                          return _buildReviewItem(
                            imageUrl: driver!.image ?? profileImage,
                            name: driver!.fullname ?? 'Anonymous',
                            rating:
                            double.parse(driver!.averageRating.toString()) ??
                                0.0,
                            review: driver!.reviews[index].review.toString() ??
                                'No review provided',
                          );
                        },
                      ),),
                    ),
                    // Write Review Button
                    CustomButton(
                      text: 'Write Review',
                      onPressed: () {
                        Get.to(() => WriteReviewView(driver!.id));
                      },
                      gradientColors: AppColors.gradientColorGreen,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconLabel({
    required String icon,
    required String label,
    required Color backgroundColor,
  }) {
    return Container(
      padding: label.isEmpty
          ? const EdgeInsets.all(8)
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Image.asset(icon, scale: 4, color: AppColors.white),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ],
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
                errorBuilder: (context, error, stackTrace) => Image.network(
                  profileImage,
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
