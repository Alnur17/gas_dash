import 'dart:async';
import 'package:gas_dash/app/data/api.dart';
import 'package:gas_dash/common/app_constant/app_constant.dart';
import 'package:gas_dash/common/helper/local_store.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:geolocator/geolocator.dart'; // Add geolocator package

class SocketService {
  late IO.Socket _socket;
  final _messageList = <Map<String, dynamic>>[].obs;
  final _friendList = <Map<String, dynamic>>[].obs;
  final _onlineUserList = <dynamic>[].obs;
  Timer? _locationTimer; // Timer for periodic location emission

  List<Map<String, dynamic>> get messageList => _messageList;
  List<Map<String, dynamic>> get friendList => _friendList;
  List<dynamic> get onlineUserList => _onlineUserList;

  IO.Socket get socket => _socket;

  Future<SocketService> init() async {
    String? token = LocalStorage.getData(key: AppConstant.accessToken);
    String? userId = LocalStorage.getData(key: AppConstant.userId);

    _socket = IO.io(Api.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {
        'token': token != null ? token : ""
      },

    });

    _socket.on('connect', (data) {
      print('🟢 Socket connected');
      print('My user ID: $userId');

      _socket.emit("connection", userId);
      // Start sending location every 3 seconds after connection

      _socket.on('newOrder', (data) {
        print('newOrder event received: $data');
      });

      _startLocationUpdates();
    });

    _socket.onConnect((_) {
      print('🟢 Socket connected');
    });

    _socket.on('onlineUser', (data) {
      onlineUserList.clear();
      for (var element in data) {
        if (element is String) {
          onlineUserList.add(element);
        }
      }
      print("Last user active on server: ${onlineUserList.length}");
      print("Last user: $onlineUserList");
    });

    _socket.onDisconnect((_) {
      init();
      print('🔴 Socket disconnected');
      // Cancel location updates on disconnect
      _stopLocationUpdates();
    });

    // Return the SocketService instance
    return this;
  }

  // Method to get current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // Method to start sending location updates every 3 seconds
  void _startLocationUpdates() {
    // Cancel any existing timer to avoid duplicates
    _stopLocationUpdates();

    _locationTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (_socket.connected) {
        try {
          final position = await _getCurrentLocation();
          final locationData = {
            "latitude": position.latitude,
            "longitude": position.longitude,
          };
          _socket.emit('setLocation', locationData);
               print('My Location>>>>>>>>>  location: $locationData');
        } catch (e) {
          print('Error getting location: $e');
        }
      } else {
        print('Socket not connected, skipping location emission');
      }
    } );

    print(">>>>>>>>> ${LocalStorage.getData(key: AppConstant.role)}");

    if(LocalStorage.getData(key: AppConstant.role) == "driver"){
      _locationTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
        if (_socket.connected) {
          try {
            final position = await _getCurrentLocation();
            final locationData = {
              "latitude": position.latitude,
              "longitude": position.longitude,
              "orderId": LocalStorage.getData(key: AppConstant.userId),
            };
            _socket.emit('getLocation', locationData);
       //     print('Emitted location: $locationData');
          } catch (e) {
            print('Error getting location: $e');
          }
        } else {
          print('Socket not connected, skipping location emission');
        }
      } );
    }


  }

  // Method to stop sending location updates
  void _stopLocationUpdates() {
    _locationTimer?.cancel();
    _locationTimer = null;
  }

  void disconnect() {
    _stopLocationUpdates(); // Stop location updates before disconnecting
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