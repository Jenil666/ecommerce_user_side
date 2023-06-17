import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;


class NotificationHelper
{
  static NotificationHelper notificationHelper = NotificationHelper._();
  NotificationHelper._();

  // todo notification

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettings =
    AndroidInitializationSettings("notification");

    DarwinInitializationSettings darwinInitializationSettings =
    DarwinInitializationSettings();

    InitializationSettings initialization = InitializationSettings(
      android: initializationSettings,
      iOS: darwinInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initialization);
  }

  Future<void> showNotification({required title, required body}) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      "123",
      "Jenil",
      sound: RawResourceAndroidNotificationSound("aleart"),
      playSound: true,
    );
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
        123, "$title", "$body", notificationDetails);
  }

  Future<void> scheduleNotification() async {
    AndroidInitializationSettings initializationSettings =
    AndroidInitializationSettings("notification");

    DarwinInitializationSettings darwinInitializationSettings =
    DarwinInitializationSettings();

    InitializationSettings initialization = InitializationSettings(
      android: initializationSettings,
      iOS: darwinInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initialization);
    tz.initializeTimeZones();
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("123", "Jenil",
        playSound: true,
        sound: RawResourceAndroidNotificationSound("aleart"));
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Flutter",
        "Schedule Notification",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> bidPicture() async {
    String link =
        "https://pbs.twimg.com/media/FtHeBl1aEAQOjks?format=jpg&name=large";
    String base64 = await uriToBase64(link);
    BigPictureStyleInformation big = await BigPictureStyleInformation(
        ByteArrayAndroidBitmap.fromBase64String(base64));
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails();
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("1", "Jenil", styleInformation: big);
    NotificationDetails notificationDetails = NotificationDetails(
        iOS: darwinNotificationDetails, android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        1, "BigPicture", "Image", notificationDetails);
  }

  Future<String> uriToBase64(String link) async {
    var response = await http.get(Uri.parse(link));
    var base64 = base64Encode(response.bodyBytes);
    return base64;
  }

  Future<void> initFireBaseMsg() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var fmcToken = await firebaseMessaging.getToken();
    print("Token ==== $fmcToken");
    await firebaseMessaging.setAutoInitEnabled(true);

    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      sound: true,
      criticalAlert: false,
      provisional: false,
    );

    FirebaseMessaging.onMessage.listen((msg) {
      if (msg.notification != null) {
        String? title = msg.notification!.title;
        String? body = msg.notification!.body;
        showNotification(title: title, body: body);
      }
    });
  }
}