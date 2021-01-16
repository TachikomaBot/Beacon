import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'channelId',
    'channelName', 
    'channelDescription',
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: true,
    autoCancel: true,
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

NotificationDetails get _dismissible {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'channelId',
    'channelName',
    'channelDescription',
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: false,
    autoCancel: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showNotificationDismissible(
    FlutterLocalNotificationsPlugin notifications, {
      @required String title,
      @required String body,
      @required NotificationDetails type,
      int id = 0,
    }) =>
    showNotification(notifications, title: title, body: body, type: _dismissible);


Future showNotificationOngoing(
  FlutterLocalNotificationsPlugin notifications, {
    @required String title,
    @required String body,
    @required NotificationDetails type,
    int id = 0,
  }) =>
  showNotification(notifications, title: title, body: body, type: _ongoing);


Future showNotification(
  FlutterLocalNotificationsPlugin notifications, {
    @required String title,
    @required String body,
    @required NotificationDetails type,
    int id = 0,
  }) =>
  notifications.show(id, title, body, type);




// class LocalNotificationWidget extends StatefulWidget{
//   @override
//   PushNotificationState createState() => PushNotificationState();
// }

// class PushNotificationState extends State<LocalNotificationWidget> {
//   final notifications = FlutterLocalNotificationsPlugin();
//   @override
//   void initState() {
//     super.initState();
//     //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     final initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//     final initializationSettingsIOS = IOSInitializationSettings();

//     notifications.initialize(
//       InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS)
//     );
//     //var initializationSettings = InitializationSettings(
//     //    initializationSettingsAndroid, initializationSettingsIOS);

//   }
//   // Future<void> showNotificationWithoutSound() async {
//   // var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//   //     'your channel id', 'your channel name', 'your channel description',
//   //     playSound: false, importance: Importance.Max, priority: Priority.High);
//   // var iOSPlatformChannelSpecifics =
//   //     new IOSNotificationDetails(presentSound: false);
//   // var platformChannelSpecifics = new NotificationDetails(
//   //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//   // await notifications.show(
//   //   0,
//   //   'New Post',
//   //   'How to Show Notification in Flutter',
//   //   platformChannelSpecifics,
//   //   payload: 'No_Sound',
//   //   );
//   // }


//   NotificationDetails get _ongoing {
//     final androidChannelSpecifics = AndroidNotificationDetails(
//       'channelId',
//       'channelName', 
//       'channelDescription',
//       importance: Importance.Max,
//       priority: Priority.High,
//       ongoing: true,
//       autoCancel: true,
//     );
//     final iOSChannelSpecifics = IOSNotificationDetails();
//     return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
//   }

//   Future showNotification(
//     FlutterLocalNotificationsPlugin notifications, {
//       @required String title,
//       @required String body,
//       @required NotificationDetails type,
//       int id = 0,
//     }
//   ) =>
//   notifications.show(id, title, body, type);

//   Future showNotificationOngoing(
//     FlutterLocalNotificationsPlugin notifications, {
//       @required String title,
//       @required String body,
//       @required NotificationDetails type,
//       int id = 0,
//     }
//   ) =>
//   showNotification(notifications, title: title, body: body, type: _ongoing);

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return null;
//   }
// }





// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// @override
// initState() {
//   //super.initState();

//   var initializationSettingsAndroid = new AndroidInitializationSettings("@mipmap/ic_launcher");
//   var initializationSettingsIOS = new IOSInitializationSettings();
//   var initializationSettings = new InitializationSettings(
//     initializationSettingsAndroid, initializationSettingsIOS);

//   flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

//   flutterLocalNotificationsPlugin.initialize(initializationSettings);


// }

