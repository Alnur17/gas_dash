import 'package:gas_dash/app/data/api.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;




class SocketService {
  late IO.Socket _socket;
  // List to store received messages
  final _messageList = <Map<String, dynamic>>[].obs;
  final _friendList = <Map<String, dynamic>>[].obs;
  final  _onlineUserList = <dynamic>[].obs;

  List<Map<String, dynamic>> get messageList => _messageList;
  List<Map<String, dynamic>> get friendList => _friendList;
  List<dynamic> get onlineUserList => _onlineUserList;


  IO.Socket get socket => _socket;

  Future<SocketService> init() async {

    String token = LocalStorage.getData(key: AppConstant.accessToken);
    String userId = LocalStorage.getData(key: AppConstant.accessToken);

    _socket = IO.io("${Api.socketUrl}", <String, dynamic>{ //http://192.168.10.152:5001

      'transports': ['websocket'],
      'autoConnect': true, // Auto connect to the server
      'extraHeaders': {
        'token': token
      },
    });

    _socket.on('connect', (data) {
      print('Connected to the server');
      print('My user ID : : $userId');

      _socket.emit("connection",userId);
    });

    _socket.onConnect((_) {
      print('Connected to socket server');
    });

    _socket.on('onlineUser', (data) {
      onlineUserList.clear();
      for (var element in data) {
        if (element is String) {
          onlineUserList.add(element);
        }
      }
      print("last user active on server: : ${onlineUserList.length}");
      print("last user : ${onlineUserList}");
      // _handleIncomingFriends(data);
    });


    _socket.onDisconnect((_) {
      print('Disconnected from socket server');
    });

    // Return the SocketService instance
    return this;
  }

  void disconnect() {
    _socket.disconnect();
  }
  Future<dynamic> emitWithAck(String event, dynamic data) async {
    return socket.emitWithAck(event, data);
  }

  void _handleIncomingFriends(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('receiver')) {
      _friendList.add(data);
      print('Friend received and added to list: ${_friendList.length}');
    }
  }
}
