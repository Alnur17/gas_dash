// import 'package:flutter/material.dart';
// import 'package:gas_dash/common/app_color/app_colors.dart';
// import 'package:gas_dash/common/app_images/app_images.dart';
// import 'package:gas_dash/common/app_text_style/styles.dart';
// import 'package:gas_dash/common/helper/upload_widget.dart';
// import 'package:gas_dash/common/size_box/custom_sizebox.dart';
// import 'package:gas_dash/common/widgets/custom_button.dart';
//
// import 'package:get/get.dart';
//
// import '../../../../../common/widgets/custom_circular_container.dart';
//
// class DriverProofOfDeliveryView extends GetView {
//   final String? deliveryId;
//   const DriverProofOfDeliveryView(this.deliveryId, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.mainColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.mainColor,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 12),
//           child: CustomCircularContainer(
//             imagePath: AppImages.back,
//             onTap: () {
//               Get.back();
//             },
//             padding: 2,
//           ),
//         ),
//         title: Text(
//           'Proof Of Delivery',
//           style: titleStyle,
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Upload Photo',
//                   style: h5,
//                 ),
//                 Image.asset(
//                   AppImages.close,
//                   scale: 4,
//                 ),
//               ],
//             ),
//             sh8,
//             UploadWidget(
//               onTap: () {},
//               imagePath: AppImages.add,
//               label: 'Choose File',
//             ),
//             sh20,
//             CustomButton(
//               text: 'Submit',
//               onPressed: () {
//                 _showSubmissionCompletedModal(context);
//               },
//               gradientColors: AppColors.gradientColorGreen,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showSubmissionCompletedModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent, // for rounded corners effect
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10,
//                 offset: Offset(0, -3),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Circle Icon with green check
//               Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   color: AppColors.gradientColorGreen[1].withOpacity(0.15),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Image.asset(AppImages.submit,scale: 4,),
//               ),),
//               const SizedBox(height: 16),
//               Text(
//                 'Your Submission is Completed',
//                 style: h3.copyWith(fontSize: 20),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               CustomButton(
//                 text: 'Return to Home',
//                 onPressed: () {},
//                 gradientColors: AppColors.gradientColorGreen,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/driver/driver_dashboard/views/driver_dashboard_view.dart';
import 'package:gas_dash/common/app_color/app_colors.dart';
import 'package:gas_dash/common/app_images/app_images.dart';
import 'package:gas_dash/common/app_text_style/styles.dart';
import 'package:gas_dash/common/helper/upload_widget.dart';
import 'package:gas_dash/common/size_box/custom_sizebox.dart';
import 'package:gas_dash/common/widgets/custom_button.dart';
import 'package:gas_dash/common/widgets/custom_circular_container.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../../common/helper/local_store.dart';
import '../../../../../common/widgets/custom_loader.dart';
import '../../../../data/api.dart';
import '../../../../data/base_client.dart';
import '../controllers/driver_completion_checklist_controller.dart';

class DriverProofOfDeliveryView
    extends GetView<DriverCompletionChecklistController> {
  final String? deliveryId;
  final String? orderId;

  const DriverProofOfDeliveryView(this.deliveryId, this.orderId, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverCompletionChecklistController());
    final selectedImage = Rx<File?>(null);
    var isPickingImage = false; // Flag to prevent multiple image picks

    Future<void> pickImage() async {
      if (isPickingImage) return;
      isPickingImage = true;
      try {
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          selectedImage.value = File(pickedFile.path);
          debugPrint(
              'Selected image path: ${pickedFile.path}'); // Debug the path
          Get.snackbar('Success', 'Image selected',
              backgroundColor: AppColors.gradientColorGreen[0],
              colorText: Colors.white);
        } else {
          debugPrint('No image selected');
        }
      } catch (e) {
        debugPrint('Error picking image: $e');
        Get.snackbar('Error', 'Failed to pick image',
            backgroundColor: AppColors.orange, colorText: Colors.white);
      } finally {
        isPickingImage = false;
      }
    }

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
          'Proof Of Delivery',
          style: titleStyle,
        ),
        centerTitle: true,
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Photo',
                  style: h5,
                ),
                sh8,
                UploadWidget(
                  onTap: pickImage,
                  imagePath: selectedImage.value == null ? AppImages.add : null,
                  fileImage: selectedImage.value,
                  label: 'Choose File',
                ),
                sh20,
                Obx(
                  () => controller.isLoading.value == true
                      ? CustomLoader(
                          color: AppColors.white,
                        )
                      : CustomButton(
                          text: 'Submit',
                          onPressed: () async {
                            if (selectedImage.value != null &&
                                deliveryId != null &&
                                orderId != null) {
                              final accessToken = LocalStorage.getData(
                                  key:
                                      'accessToken'); // Adjust key as per your app
                              final headers = {
                                'Content-Type': 'multipart/form-data',
                                'Authorization': 'Bearer $accessToken',
                              };

                              var request = http.MultipartRequest('PATCH',
                                  Uri.parse(Api.updateDelivery(deliveryId!)))
                                ..fields['data'] =
                                    jsonEncode({'status': 'delivered'})
                                ..files.add(await http.MultipartFile.fromPath(
                                    'proofImage', selectedImage.value!.path))
                                ..headers.addAll(headers);

                              final response = await http.Response.fromStream(
                                  await request.send());
                              final result =
                                  await BaseClient.handleResponse(response);

                              if (result != null &&
                                  (result['success'] == true ||
                                      result['message'] ==
                                          'Delivery updated successfully')) {
                                await controller.submitAnswers(
                                    deliveryId!, orderId!);
                                _showSubmissionCompletedModal(context);
                              }
                            } else {
                              Get.snackbar('Error',
                                  'Please select an image and ensure delivery ID and order ID are valid',
                                  backgroundColor: AppColors.orange,
                                  colorText: Colors.white);
                            }
                          },
                          gradientColors: AppColors.gradientColorGreen,
                        ),
                ),
              ],
            ),
          )),
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
                  child: Image.asset(AppImages.submit, scale: 4),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your Submission is Completed',
                style: h3.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Return to Home',
                onPressed: () {
                  Get.offAll(() => DriverDashboardView());
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
