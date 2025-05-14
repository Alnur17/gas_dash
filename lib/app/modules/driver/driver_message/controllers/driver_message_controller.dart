import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverMessageController extends GetxController {
  var messages = <Message>[].obs;

  // Add a new message
  void addMessage(String text, bool isSent) {
    final time = TimeOfDay.now().format(Get.context!);
    messages.add(Message(text: text, time: time, isSent: isSent));
  }
}


class Message {
  final String text;
  final String time;
  final bool isSent;

  Message({required this.text, required this.time, required this.isSent});
}
