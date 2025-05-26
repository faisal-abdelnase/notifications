
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifications/services/local_notifications_service.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async{

    await messaging.requestPermission();

    String? token = await messaging.getToken();
    log('Push Notifications Token: ${token ?? "Null"}');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);


    // Handle foreground messages

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      // show local notification
      LocalNotificationService.showBasicNotification(
        message.notification?.title ?? "Null", 
        message.notification?.body ?? "Null");
    });

  }




  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    print(message.notification?.body ?? "Null");
    log(message.notification?.title ?? "Null");

    // You can handle the background message here
  }

}