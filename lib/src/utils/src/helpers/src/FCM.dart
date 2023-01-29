import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carzoum/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  debugPrint(
      "#################################### app in background notification recieved ##################################");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (message.notification != null) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: message.notification?.title ?? "CarZoum",
        body: message.notification?.body ?? "N/A",
        actionType: ActionType.Default,
      ),
    );
  }
}

class FCM {
  FCM._();

  factory FCM() {
    return _instance;
  }

  static final FCM _instance = FCM._();
  static FCM get instance => _instance;

  static final _firebaseMessaging = FirebaseMessaging.instance;

  static final streamCtlr = StreamController<String>.broadcast();
  static final titleCtlr = StreamController<String>.broadcast();
  static final bodyCtlr = StreamController<String>.broadcast();

  static setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    // AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: 10,
    //     channelKey: 'basic_channel',
    //     title: 'CarZoum Testing',
    //     body: 'Testing notification services',
    //     actionType: ActionType.Default,
    //   ),
    // );

    // handle when app in active state
    foregroundNotification();

    // handle when app running in background state
    backgroundNotification();

    // handle when app completely closed by the user
    terminateNotification();

    // With this token you can test it easily on your phone
    // final token =
    //     _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  static foregroundNotification() {
    FirebaseMessaging.onMessage.listen(
      (message) async {
        debugPrint(
            "#################################### foreground notification recieved ##################################");

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: message.notification?.title ?? "CarZoum",
            body: message.notification?.body ?? "N/A",
            actionType: ActionType.Default,
          ),
        );
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
  }

  static backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        debugPrint(
            "#################################### user clicked the notification  ##################################");

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: message.notification?.title ?? "CarZoum",
            body: message.notification?.body ?? "N/A",
            actionType: ActionType.Default,
          ),
        );

        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
  }

  static terminateNotification() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    print(
        "#################################### terminated app notification recieved ##################################");

    if (initialMessage != null) {
      if (initialMessage.data.containsKey('data')) {
        // Handle data message
        streamCtlr.sink.add(initialMessage.data['data']);
      }
      if (initialMessage.data.containsKey('notification')) {
        // Handle notification message
        streamCtlr.sink.add(initialMessage.data['notification']);
      }
      // Or do other work.
      titleCtlr.sink.add(initialMessage.notification!.title!);
      bodyCtlr.sink.add(initialMessage.notification!.body!);
    }
  }

  static dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}
