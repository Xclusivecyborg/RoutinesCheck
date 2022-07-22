import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:routine_checks_mobile/domain/enum.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final NotificationHelper _instance = NotificationHelper._internal();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  factory NotificationHelper() {
    return _instance;
  }

  NotificationHelper._internal();

  initialiseNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    void _onDidReceiveLocalNotification(
        int id, String? title, String? body, String? payload) {}

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  show(
      {required int id,
      required String title,
      required String body,
      String payload = '',
      required DateTime shceduleDate,
      required FrequencyType periodically}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'main_channel',
      'Main Channel',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      timeoutAfter: 300000,
    );

    const IOSNotificationDetails iosPlatformChannelSpecifics =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "It's time for your routine $title",
        body,
        tz.TZDateTime.from(shceduleDate, tz.local),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
  }

  cancel(id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
