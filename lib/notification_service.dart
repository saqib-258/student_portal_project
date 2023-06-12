import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get notifications => _notifications;

  Future<void> showNotification(
      String title, String message, String payload) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('default_notification_channel_id',
            'Default notification channel name',
            channelDescription: 'Default notification channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await notifications.show(
      0,
      title,
      message,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showAppNotification(
      List<String> messages, String payload) async {
    int messageCount = messages.length;

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'default_notification_channel_id',
      'Default notification channel name',
      channelDescription: 'Default notification channel description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: InboxStyleInformation(
        messages,
        contentTitle: '${messageCount.toString()} New Notifications',
      ),
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await notifications.show(
      0,
      'New Messages',
      '',
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
