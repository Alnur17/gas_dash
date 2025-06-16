import 'package:flutter/material.dart';
import 'package:gas_dash/app/data/api.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'message_controller.dart';


class MessageSendController extends GetxController {
  var isLoading = false.obs;
  final MessageController messageController = Get.put(MessageController());
  final TextEditingController messageTextController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var selectedImagePath = ''.obs;
  var imageSend = false.obs;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<void> sendMessage(String receiverId, String text,String image) async {
    const url = Api.sendMessage;
    isLoading.value = true;
    // Get the token from UserPreference

    String token = LocalStorage.getData(key: AppConstant.accessToken);

    // Prepare the headers
    var headers = {
      'Accept': 'application/json',
      'Authorization': "Bearer $token" ?? '',  // Handle possible null token
    };

    // Prepare the form data
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    // Add text data
    request.fields['data'] = jsonEncode({
      'receiver': receiverId,
      'text': text,
    });

    // Add the image file if available
    if (selectedImagePath.value.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }

    // Send the request
    try {
      var response = await request.send();

      messageTextController.clear();
      if (response.statusCode == 200) {
        messageTextController.clear();
        print('Message sent successfully');
        isLoading.value = false;
      } else {
        print('Failed to send message');
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
    }
  }
}