import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/notification_services.dart';
import 'app/routes/app_pages.dart';
import 'common/app_constant/app_constant.dart';
import 'common/helper/local_store.dart';
import 'common/helper/socket_service.dart';
import 'firebase_options.dart';

/// 🔹 Must be a TOP-LEVEL function
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Background message received: ${message.notification?.title}');
  // you can show a local notification here if needed
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  // Initialize SocketService
  await Get.putAsync(() => SocketService().init());

  final NotificationServices notificationServices = NotificationServices();

  // ask permission
  notificationServices.requestNotificationPermission();

  // get token
  notificationServices.getDeviceToken().then((value) {
    debugPrint('=============== > Device Token: $value < ==================');
    LocalStorage.saveData(key: AppConstant.fcmToken, data: value);

    String fcmToken = LocalStorage.getData(key: AppConstant.fcmToken);
    debugPrint('=========>fcm Token from local storage: $fcmToken <========');
  });

  // 🔹 register the top-level handler for background messages
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // configure local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  await notificationServices.flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        print('Notification payload: ${response.payload}');
      }
    },
  );

  // foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Foreground message received: ${message.notification?.title}');
    notificationServices.showNotification(
      message.notification?.title,
      message.notification?.body,
    );
  });

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gas Dash",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
