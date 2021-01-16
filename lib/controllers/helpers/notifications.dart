import 'package:Beacon/controllers/notifier/notification_message.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

showVideoNotification(){
  final notifications = FlutterLocalNotificationsPlugin();

  final settingsAndroid = AndroidInitializationSettings('icon_launcher');
  final settingsIOS = IOSInitializationSettings();
  notifications.initialize(
      InitializationSettings(settingsAndroid, settingsIOS)
  );

  showNotificationDismissible(notifications, title: 'Recording Uploaded', body: 'Video recording uploaded to your Google Drive', type: null);
}

showMessageNotification(){
  final notifications = FlutterLocalNotificationsPlugin();

  final settingsAndroid = AndroidInitializationSettings('icon_launcher');
  final settingsIOS = IOSInitializationSettings();
  notifications.initialize(
      InitializationSettings(settingsAndroid, settingsIOS)
  );

  showNotificationDismissible(notifications, title: 'Alerts Sent', body: 'Alerts sent to your contacts', type: null);
}