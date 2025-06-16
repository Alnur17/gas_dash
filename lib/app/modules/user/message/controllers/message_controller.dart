import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/data/api.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../common/helper/socket_service.dart';
import '../chat_message_model.dart';

class MessageController extends GetxController {
  var messages = <Message>[].obs;

  final SocketService socketService = Get.put(SocketService());
  var isLoading = false.obs;

  var message = ChatMessagesModel().obs;
  var messageList = <ChatMessage>[].obs;


  ///friendshipChat sms

  Future<void> getFriendshipChat({
    required String chatId,

  }) async {
    try {
      isLoading(true);

      String token = LocalStorage.getData(key: AppConstant.accessToken);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token" ?? '',  // Handle possible null token
      };

      var response = await http.get(
        Uri.parse(Api.chatDetails(chatId)),
        headers: headers.map((key, value) => MapEntry(key, value.toString())), // Cast values to strings
      );

      if (response.statusCode == 200) {
        messageList.clear();

        message.value = ChatMessagesModel.fromJson(jsonDecode(response.body));
        messageList.addAll(message.value.data!.data);
        print(messageList.length);

        socketService.messageList.clear();

        for (var i = 0; i < messageList.length; i++) {
          socketService.messageList.add(
              {
                "id": messageList[i].id.toString(),
                "text": messageList[i].text.toString(),
                "imageUrl": messageList[i].imageUrl.toString(),
                "seen":  messageList[i].seen,
                "sender": messageList[i].sender?.id.toString(),
                "receiver": messageList[i].receiver?.id.toString(),
                "chat": messageList[i].chat.toString(),
                "_id": messageList[i].id.toString(),
                "sendTime": messageList[i].createdAt,
              }
          );


        }


      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody['message'] ?? 'Something went wrong';

        // Show the error message using Get.snackbar
        Get.snackbar("Failed", errorMessage,);
      }
    } catch (e) {
      // Handle the exception as needed
      print(e.toString());
      // Example: kSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isLoading(false);
    }
  }

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
