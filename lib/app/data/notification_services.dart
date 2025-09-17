import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Background message handler
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Background message received: ${message.notification?.title}');
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      providesAppNotificationSettings: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User denied permission');
    }
  }

  Future<void> showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',            // Notification channel ID
      'Your Channel Name',          // Notification channel name
      channelDescription: 'Your channel description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails darwinPlatformChannelSpecifics =
    DarwinNotificationDetails();



    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,         // Notification ID
      title,     // Notification title
      body,      // Notification body
      platformChannelSpecifics,
    );
  }


  // void firebaseInit(){
  //   FirebaseMessaging.onMessage.listen((message) {
  //
  //   },);
  // }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen(
      (event) {
        event.toString();
        debugPrint('Refresh token $event');
      },
    );
  }

}
