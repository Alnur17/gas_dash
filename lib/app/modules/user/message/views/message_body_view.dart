import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/helper/local_store.dart';
import '../../../../../common/helper/socket_service.dart';
import '../controllers/message_controller.dart';
import '../controllers/message_send_controller.dart';

class ChattingPage extends StatefulWidget {
  final String chatId;
  final String receiverId;
  final String receiverName;
  final String receiverImage;
  const ChattingPage({super.key, required this.chatId, required this.receiverId, required this.receiverName, required this.receiverImage});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  final SocketService socketService = Get.put(SocketService());
  final MessageController messageChatController = Get.put(MessageController());
  final MessageSendController messageSendController = Get.put(MessageSendController());
  final ScrollController _scrollController = ScrollController();

  String metaTitle = '';

  @override
  void initState() {
    socketService.init();
    socketService.socket.on('new-message::${widget.chatId}', (data) {
      print("Socket new message received >>>>>>>>>>>>>>>>>>>>>>>");
      _handleIncomingMessage(data);
    });
    socketService.socket.emit('seen', {'chatId': widget.chatId});
    messageChatController.getFriendshipChat(chatId: widget.chatId).then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToEnd();
      });
    });
    super.initState();
  }



  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _handleIncomingMessage(dynamic data) {
    if (data != null && data is Map<String, dynamic>) {
      socketService.messageList.add(data);
      print("${socketService.messageList.length} this is message list demo length");
      _scrollToEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    socketService.init().then((_) {
      print("Socket initialized ))))))))))))))))))))))))))))))))))");
    });
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Row(
          children: [Text(widget.receiverName.toString())],
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Obx(() => messageChatController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : messageChatController.messageList.isEmpty
          ? Center(child: Text("No Data Found".tr))
          : ListView.builder(
        controller: _scrollController,
        itemCount: socketService.messageList.length,
        itemBuilder: (context, index) {
          String formattedTime = DateFormat('d MMM yyyy - hh:mma')
              .format(socketService.messageList[index]["sendTime"] ?? DateTime.now());
          var userId = LocalStorage.getData(key: "userId");
          var senderId = socketService.messageList[index]["sender"] ?? '';

          return Align(
            alignment: userId == senderId ? Alignment.topRight : Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10, bottom: 5, left: 10),
                    decoration: BoxDecoration(
                      color: userId == senderId ? AppColors.white : AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: userId == senderId ? Radius.circular(10) : Radius.circular(0),
                        bottomRight: userId == senderId
                            ? Radius.circular(0)
                            : socketService.messageList[index]["showButton"] == true
                            ? Radius.circular(0)
                            : Radius.circular(10),
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
                    ),
                    child: Text(
                      socketService.messageList[index]["text"]?.toString() ?? '',
                      style: TextStyle(color: userId == senderId ? AppColors.black : AppColors.white),
                    ),
                  ),
                  Text(formattedTime, style: const TextStyle(fontSize: 10), textAlign: TextAlign.end),
                ],
              ),
            ),
          );
        },
      )),
      bottomNavigationBar: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          curve: Curves.decelerate,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(2, 2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => messageSendController.selectedImagePath.value.isNotEmpty
                    ? Stack(
                  children: [
                    Image.file(File(messageSendController.selectedImagePath.value), height: 50),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => messageSendController.selectedImagePath.value = "",
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(Icons.close, color: Colors.red, size: 14),
                        ),
                      ),
                    ),
                  ],
                )
                    : const SizedBox()),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textAlign: TextAlign.left,
                        textInputAction: TextInputAction.done,
                        minLines: 1,
                        controller: messageSendController.messageTextController,
                        style: GoogleFonts.raleway(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 12, bottom: 12),
                          fillColor: Colors.transparent,
                          filled: true,
                          hintText: "Type message",
                          hintStyle: GoogleFonts.raleway(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        final text = messageSendController.messageTextController.text.trim();
                        final imagePath = messageSendController.selectedImagePath.value;
                        if (text.isNotEmpty || imagePath.isNotEmpty) {
                          final data = {
                            'receiver': widget.receiverId,
                            'text': messageSendController.messageTextController.text,
                          };
                          try {
                            print('Sending message with data: $data');
                            final ack = await socketService.emitWithAck('send-message', data);
                            print('Acknowledgment received: $ack, type: ${ack.runtimeType}');
                            print("send dddd");
                            messageSendController.messageTextController.clear();
                            if (ack == true) {
                              messageSendController.messageTextController.clear();

                              _scrollToEnd();
                            } else {
                              print('Acknowledgment failed or invalid: $ack');
                            }
                          } catch (e) {
                            print('Error sending message: $e');
                          }
                        }
                      },
                      child:  Icon(Icons.send, color: AppColors.primaryColor.withOpacity(0.5), size: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}