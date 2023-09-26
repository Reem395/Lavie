
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/view/chat_screen/chat_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../utils/constants.dart';

Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage? message) async {}

class NotifivationAPI {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? deviceToken;

  final _androidChannel = const AndroidNotificationChannel(
      'Notification_channel', 'Android Notification Channel',
      importance: Importance.defaultImportance);
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future initNotifications() async {
    await messaging.requestPermission();
    deviceToken = await messaging.getToken();
    print("Notifications deviceToken $deviceToken");
    initPushNotification();
    initLocalNotification();
  }

  void handleMessage(RemoteMessage? msg) {
    print("from handle msg: $msg");
    if (msg == null) return;

    print("navigatorKey.currentContext!: ${navigatorKey.currentContext!}");
    print("navigatorKey.currentwidget!: ${navigatorKey.currentWidget!}");
    navigatorKey.currentState?.push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const ChatScreen()));
  }

  Future initLocalNotification() async {
    //  const ios = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const settings = InitializationSettings(
        android: android, iOS: initializationSettingsDarwin);

    await _localNotifications.initialize(
      settings,
      // onDidReceiveNotificationResponse: (payload) {
      //   print("payload : $payload");
      //   final msg = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      //   print("payload.payload : ${payload.payload}");
      //   print("payload msg : $msg");
      //   handleMessage(msg);
      // },
      // onDidReceiveBackgroundNotificationResponse: (payload) {
      //   print("payload : $payload");
      //   final msg = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      //   handleMessage(msg);
      // }
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotification() async {
    await messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    messaging.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((handleMessage));
    FirebaseMessaging.onBackgroundMessage(
        (_firebaseMessagingBackgroundHandler));

    // Handle notifications received while the app is in the foreground
    FirebaseMessaging.onMessage.listen((msg) {
      final notification = msg.notification;
      if (notification == null) return;
      if (!isOnChatScreen(navigatorKey.currentContext!)) {
        _localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    _androidChannel.id, _androidChannel.name,
                    icon: '@drawable/ic_launcher')));
        // RemoteMessage x = jsonEncode(msg.toMap()) as RemoteMessage;
        // print("x from jsonEncode :${x.notification?.body}");
      }

      // handleMessage(msg);
      print("notification recieved");
    });
  }

  var t = {
    "senderId": null,
    "category": null,
    "collapseKey": "com.example.flutter_application_1",
    "contentAvailable": false,
    "data": {},
    "from": "/topics/all_users",
    "messageId": "0:1691522328024846%f71274eef71274ee",
    "messageType": null,
    "mutableContent": false,
    "notification": {
      "title": "Hello",
      "titleLocArgs": [],
      "titleLocKey": null,
      "body": "8",
      "bodyLocArgs": [],
      "bodyLocKey": null,
      "android": {
        "channelId": null,
        "clickAction": null,
        "color": null,
        "count": null,
        "imageUrl": null,
        "link": null,
        "priority": 0,
        "smallIcon": null,
        "sound": null,
        "ticker": null,
        "tag": "topic_key_5299880970841548702",
        "visibility": 0
      },
      "apple": null,
      "web": null
    },
    "sentTime": 1691522327696,
    "threadId": null,
    "ttl": 2419200
  };
  bool isOnChatScreen(BuildContext context) {
    // Use the Navigator to check if there is a route that can be popped
    return Navigator.of(context).canPop();
  }

  static Future<void> sendNotification({required String body}) async {
    print("body from senNoti: $body , dTok: $deviceToken");
    final dio = Dio();

    const url = 'https://fcm.googleapis.com/fcm/send';
    final headers = {
      'Authorization':
          'Bearer AAAA5fv1NbI:APA91bGosoTNk5I4820_vqmqffdWbHmcklZ3WgDRDcO_2BZGmoKTnzwDa0EoCKf6LMU4uGqgc7HUOkSgahalR3V-kI-ibqUlnlUZSWBywRuaAymBiYGPLlKTMeIyd3ptsUjaTAPqf_AM',
      'Content-Type': 'application/json',
    };

    final data = {
      "to": "/topics/all_users",
      "notification": {"title": "Hello", "body": body}
    };
    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );

      print('Response: ${response.data}');
    } catch (error) {
      print('Error: $error');
    }
  }
}
