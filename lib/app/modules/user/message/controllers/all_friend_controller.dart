import 'package:flutter/material.dart';
import 'package:gas_dash/app/data/api.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../common/helper/socket_service.dart';
import '../all_friend_model.dart';


class FriendController extends GetxController {
  final SocketService socketService = Get.put(SocketService());

  var isLoading = false.obs;

  var friends = AllFriendModel(data: []).obs;
  var friendList = <Friends>[].obs;

  @override
  void onInit() {
    getAllFriends();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getAllFriends();
  }



  /// Get all Friends
  Future<void> getAllFriends() async {

    String token = LocalStorage.getData(key: AppConstant.accessToken);
    try {
      isLoading(true);

      var headers = {
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      };

      var url = Uri.parse(Api.allFriends);

      var response = await http.get(url, headers: headers);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        friendList.clear();

        friends.value = AllFriendModel.fromJson(responseBody);
        friendList.addAll(friends.value.data);
        print(
            "###################### get friends ${friendList.length} #######################");

        socketService.friendList.clear();

        if (friendList.isNotEmpty) {
          for (var i = 0; i < friendList.length; i++) {
            if (friendList[i].chat?.participants.isNotEmpty ?? false) {
              socketService.friendList.add({
                "id": friendList[i].chat?.id,
                "receiverId": friendList[i].chat?.participants[0].id,
                "name": friendList[i].chat?.participants[0].name.toString(),
                "email": friendList[i].chat?.participants[0].email.toString(),
                "image": friendList[i].chat?.participants[0].image.toString(),
                "phoneNumber": friendList[i].chat?.participants[0].phoneNumber,
                "role": friendList[i].chat?.participants[0].role,
                "last_message_text": friendList[i].message?.text,
                "last_message_image": friendList[i].message?.imageUrl,
                "unreadMessageCount": friendList[i].unreadMessageCount,
              });
              print("###################### socket $i #######################");
            } else {
              print("Participants list is empty for friend $i");
            }
          }
        } else {
          print("Friend list is empty");
        }

        print(
            "###################### get friends Socket ${socketService.friendList.length} %%%%%%%%%%%%%%%%%%%%%");

        isLoading(false);
      } else {
      //  throw 'Unable to load all friends data!';
      }
    } catch (e) {
      // Schedule the snackbar to show after the current frame is rendered
      print(e);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Error', e.toString(),
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      });
    } finally {
      isLoading(false);
    }
  }
}
