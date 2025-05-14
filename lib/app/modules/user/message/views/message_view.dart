import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/message/views/message_body_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/widgets/custom_circular_container.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  bool showChats = true;

  @override
  Widget build(BuildContext context) {
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
        title: Text('Message'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // sh16,
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: CustomTextField(
          //     preIcon: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Image.asset(
          //         AppImages.search,
          //         scale: 4,
          //       ),
          //     ),
          //     hintText: 'Search here..',
          //     borderRadius: 30,
          //   ),
          // ),
          Expanded(
            child: ChatList(),
          ),
        ],
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => MessageBodyView());
            log('message index is $index');
          },
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
              bottom: 8,
              right: 20,
              top: index == 0 ? 16 : 0,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.bottomNavbar,
                border: Border.all(color: AppColors.silver)),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(AppImages.profileImageTwo),
              ),
              title: Text(
                'Floyd Miles',
                style: h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black100,
                ),
              ),
              subtitle: Text(
                'Lorem ipsum dolor sit amet consectetur',
                style: h6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                padding: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColors.blueLight,
                ),
                child: Text(
                  '1',
                  style: h6.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
