import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get notifications => _notifications;
  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      if (payload!.isNotEmpty) {
        await OpenFilex.open(payload);
      }
    }
  }

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _notifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

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
}
