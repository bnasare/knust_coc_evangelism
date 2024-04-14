import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class PushNotification {
  Future<void> initializeNotification();
  Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  });
}

class PushNotificationImpl implements PushNotification {
  PushNotificationImpl(this.localNotification);

  final FlutterLocalNotificationsPlugin localNotification;

  @override
  Future<void> initializeNotification() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    /// initialize Local Notification
    const initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());
    await localNotification.initialize(initializationSettings);

    const channel = AndroidNotificationChannel(
      'com.builtontherock.app.botr_mobile', // id
      'BOTR', // title
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      ledColor: Color(0xFF9769EC),
      enableLights: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;
      final ios = message.notification?.apple;
      if (notification != null && android != null) {
        localNotification.show(
            message.hashCode,
            message.notification!.title,
            message.notification!.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                )));
      }
      if (notification != null && ios != null) {
        localNotification.show(
            message.hashCode,
            message.notification!.title,
            message.notification!.body,
            const NotificationDetails(iOS: DarwinNotificationDetails()));
      }
    });

  }

  @override
  Future<void> showSimpleNotification(
      {required String title,
      required String body,
      required String payload}) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('com.builtontherock.app.botr_mobile', 'BOTR',
            channelDescription: '',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
