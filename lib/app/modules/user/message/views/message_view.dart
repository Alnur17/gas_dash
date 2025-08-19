import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/auth/login/views/login_view.dart';
import 'package:gas_dash/app/modules/user/message/views/message_body_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/helper/socket_service.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../controllers/all_friend_controller.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final SocketService socketService = Get.put(SocketService());
  final FriendController friendController = Get.put(FriendController());
  final  TextEditingController searchTextController = TextEditingController();
  String search = '';

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (LocalStorage.getData(key: AppConstant.accessToken) == null) {
        Get.offAll(() => LoginView());
      }
    });
    print(socketService.onlineUserList);
    socketService.init();
    super.initState();

    socketService.socket.on('onlineUser', (data) {
      socketService.onlineUserList.clear();
      for (var element in data) {
        if (element is String) {
          socketService.onlineUserList.add(element);
        }
      }
      print("last user active on server: : ${socketService.onlineUserList.length}");
      print("last user : ${socketService.onlineUserList}");
      //friendController.getAllFriends();
      // _handleIncomingFriends(data);
    });


    Future.delayed(Duration.zero, () {
      friendController.getAllFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text("Messages"),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await  friendController.getAllFriends();
          },
          child: Obx(() =>friendController.isLoading.value == true
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : friendController.friendList.isEmpty
              ? Center(child: Text("Empty"),)
              :  ListView.builder(
              itemCount: socketService.friendList.length,
              itemBuilder: (context, index) {
                String position = socketService.friendList[index]["name"].toString();
                if(searchTextController.text.isEmpty){
                  return GestureDetector(
                    onTap: () {
                      Get.to(ChattingPage(chatId: socketService.friendList[index]["id"], receiverId: socketService.friendList[index]["receiverId"], receiverName: socketService.friendList[index]["name"], receiverImage: socketService.friendList[index]["image"],));
                    },
                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: Stack(
                                    children: [
                                      ClipOval(
                                        child:  Image.network(
                                          "${socketService.friendList[index]["image"] == "null" ? "https://edulaveworldschool.com/wp-content/uploads/2022/11/pngtree-man-vector-icon-png-image_470295.jpg" :socketService.friendList[index]["image"] }",
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                        ),
                                        //  child: Icon(Icons.person),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${socketService.friendList[index]["name"]}",),
                                        socketService.friendList[index]["unreadMessageCount"].toString() != "0"?      Container(
                                            margin: EdgeInsets.only(left: 8.0),
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text("${socketService.friendList[index]["unreadMessageCount"]}",
                                            )): SizedBox()
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(right: 4.0),
                                          child: Icon(
                                            Icons.done_all,
                                            color: AppColors.primaryColor,
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                              "${socketService.friendList[index]["last_message_text"]}",
                                              maxLines: 1),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            CircleAvatar(radius: 8,backgroundColor: socketService.onlineUserList.contains(socketService.friendList[index]["receiverId"])? Colors.green : Colors.red,)
                          ],
                        ),
                      ),
                    ),
                  );
                }else if(position.toLowerCase().contains(searchTextController.text.toLowerCase())){
                  return GestureDetector(
                    onTap: () {
                      Get.to(ChattingPage(chatId: socketService.friendList[index]["id"], receiverId: socketService.friendList[index]["receiverId"], receiverName: socketService.friendList[index]["name"], receiverImage: socketService.friendList[index]["image"],));
                    },
                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: Stack(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          "${socketService.friendList[index]["image"]}",
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${socketService.friendList[index]["name"]}",),
                                        socketService.friendList[index]["unreadMessageCount"].toString() != "0"?      Container(
                                            margin: EdgeInsets.only(left: 8.0),
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text("${socketService.friendList[index]["unreadMessageCount"]}",)): SizedBox()
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(right: 4.0),
                                          child: Icon(
                                            Icons.done_all,
                                            color: AppColors.primaryColor,
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            "${socketService.friendList[index]["last_message_text"]}",
                                            maxLines: 1,),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            CircleAvatar(radius: 8,backgroundColor: socketService.onlineUserList.contains(socketService.friendList[index]["receiverId"])? Colors.green : Colors.red,)
                          ],
                        ),
                      ),
                    ),
                  );
                }else {
                  return Container();
                }


              })),
        )
    );
  }
}



/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gas_dash/app/modules/user/message/views/message_body_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_constant/app_constant.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/helper/socket_service.dart';
import '../../../../../common/widgets/custom_circular_container.dart';
import '../controllers/all_friend_controller.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final SocketService socketService = Get.put(SocketService());
  final FriendController friendController = Get.put(FriendController());
  final  TextEditingController searchTextController = TextEditingController();
  String search = '';

  @override
  void initState() {


    print(socketService.onlineUserList);
    socketService.init();
    super.initState();

    socketService.socket.on('onlineUser', (data) {
      socketService.onlineUserList.clear();
      for (var element in data) {
        if (element is String) {
          socketService.onlineUserList.add(element);
        }
      }
      print("last user active on server: : ${socketService.onlineUserList.length}");
      print("last user : ${socketService.onlineUserList}");
      //friendController.getAllFriends();
      // _handleIncomingFriends(data);
    });


    Future.delayed(Duration.zero, () {
      friendController.getAllFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text("Messages"),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 80),
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 30),
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 229, 248, 248),
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: TextField(
                controller: searchTextController,
                onChanged: (String? value) {
                  setState(() {
                    search = value.toString();
                  });
                },
                enabled: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(2.0),
                  hintText: "Search for a Property".tr,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.greyDark,
                  ),
                  border: InputBorder.none,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ImageIcon(
                      AssetImage("assets/icons/searchIcon.png"),
                      size: 24.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await  friendController.getAllFriends();
          },
          child: Obx(() =>friendController.isLoading.value == true
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : friendController.friendList.isEmpty
              ? Center(child: Text("Empty"),)
              :  ListView.builder(
              itemCount: socketService.friendList.length,
              itemBuilder: (context, index) {
                String position = socketService.friendList[index]["name"].toString();
                if(searchTextController.text.isEmpty){
                  return GestureDetector(
                    onTap: () {
                   //   Get.to(ChattingPage(chatId: socketService.friendList[index]["id"], receiverId: socketService.friendList[index]["receiverId"], receiverName: socketService.friendList[index]["name"], receiverImage: socketService.friendList[index]["image"],));
                    },
                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: Stack(
                                    children: [
                                      ClipOval(
                                        child:  Image.network(
                                          "${socketService.friendList[index]["image"] ?? "https://edulaveworldschool.com/wp-content/uploads/2022/11/pngtree-man-vector-icon-png-image_470295.jpg"}",
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${socketService.friendList[index]["name"]}",),
                                        socketService.friendList[index]["unreadMessageCount"].toString() != "0"?      Container(
                                            margin: EdgeInsets.only(left: 8.0),
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text("${socketService.friendList[index]["unreadMessageCount"]}",
                                              )): SizedBox()
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(right: 4.0),
                                          child: Icon(
                                            Icons.done_all,
                                            color: AppColors.primaryColor,
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                              "${socketService.friendList[index]["last_message_text"]}",
                                              maxLines: 1),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            CircleAvatar(radius: 8,backgroundColor: socketService.onlineUserList.contains(socketService.friendList[index]["receiverId"])? Colors.green : Colors.red,)
                          ],
                        ),
                      ),
                    ),
                  );
                }else if(position.toLowerCase().contains(searchTextController.text.toLowerCase())){
                  return GestureDetector(
                    onTap: () {
                     // Get.to(ChattingPage(chatId: socketService.friendList[index]["id"], receiverId: socketService.friendList[index]["receiverId"], receiverName: socketService.friendList[index]["name"], receiverImage: socketService.friendList[index]["image"],));
                    },
                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: Stack(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          "${socketService.friendList[index]["image"]}",
                                          width: 55,
                                          height: 55,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${socketService.friendList[index]["name"]}",),
                                        socketService.friendList[index]["unreadMessageCount"].toString() != "0"?      Container(
                                            margin: EdgeInsets.only(left: 8.0),
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                              color: AppColors.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text("${socketService.friendList[index]["unreadMessageCount"]}",)): SizedBox()
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(right: 4.0),
                                          child: Icon(
                                            Icons.done_all,
                                            color: AppColors.primaryColor,
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                              "${socketService.friendList[index]["last_message_text"]}",
                                              maxLines: 1,),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            CircleAvatar(radius: 8,backgroundColor: socketService.onlineUserList.contains(socketService.friendList[index]["receiverId"])? Colors.green : Colors.red,)
                          ],
                        ),
                      ),
                    ),
                  );
                }else {
                  return Container();
                }


              })),
        )
    );
  }
}

*/
