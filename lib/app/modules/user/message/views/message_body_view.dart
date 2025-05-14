import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../controllers/message_controller.dart';

class MessageBodyView extends GetView {
  const MessageBodyView({super.key});
  @override
  Widget build(BuildContext context) {
    final messageController = Get.put(MessageController());
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
        titleSpacing: 8,
        title: Text(
          'Floyd Miles',
          style: TextStyle(color: Colors.black),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomCircularContainer(
              imagePath: AppImages.menu,
              backgroundColor: AppColors.silver,
              onTap: () {
                Get.back();
              },
            ),
          ),
          sw12,
          // GestureDetector(
          //   onTap: (){},
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     decoration: ShapeDecoration(
          //       shape: CircleBorder(),
          //       color: AppColors.silver,
          //     ),
          //     child: Image.asset(
          //       AppImages.menu,
          //       scale: 4,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: messageController.messages.length,
                itemBuilder: (context, index) {
                  final message = messageController.messages[index];
                  if (message.isSent) {
                    return _buildSentMessage(
                      message: message.text,
                      time: message.time,
                    );
                  } else {
                    return _buildReceivedMessage(
                      message: message.text,
                      time: message.time,
                    );
                  }
                },
              ),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(
      {required String message, required String time}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text(
            time,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        sh5,
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 8, right: 80),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(
            message,
            style: h5.copyWith(color: AppColors.black),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSentMessage({required String message, required String time}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8),
          child: Text(
            time,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        sh5,
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 8, left: 80),
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            message,
            style: h5.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    final TextEditingController textController = TextEditingController();
    final MessageController messageController = Get.find();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border(
        //   top: BorderSide(color: Colors.grey[300]!),
        // ),
      ),
      child: Row(
        children: [
          Image.asset(
            AppImages.attachFile,
            scale: 4,
          ),
          sw12,
          Expanded(
            child: CustomTextField(
              controller: textController,
              hintText: 'Message',
              borderRadius: 30,
              containerColor: AppColors.bottomNavbar,
            ),
          ),
          sw12,
          GestureDetector(
            onTap: () {
              if (textController.text.trim().isNotEmpty) {
                messageController.addMessage(textController.text.trim(), true);
                textController.clear();

                // Simulating a bot response
                Future.delayed(
                  Duration(seconds: 1),
                      () {
                    messageController.addMessage(
                      'This is an auto-reply',
                      false,
                    );
                  },
                );
              }
            },
            child: Image.asset(
              AppImages.send,
              scale: 4,
            ),
          ),
        ],
      ),
    );
  }
}

