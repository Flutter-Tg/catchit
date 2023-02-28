import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  setup() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    // inisialise
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    localNotificationsPlugin.initialize(initializationSettings);

    //prmission
    localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    // connect to channel
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  send() {
    const androidDetail = AndroidNotificationDetails(
        'high_importance_channel', // channel Id
        'High Importance Notifications' // channel Name
        );

    const noticeDetail = NotificationDetails(android: androidDetail);

    localNotificationsPlugin.show(0, 'title', 'body', noticeDetail);
  }
}
