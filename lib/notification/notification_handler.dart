import 'dart:async';

import 'package:student_portal/notification/provider/notification_provider.dart';
import 'package:student_portal/shared/get_it.dart';

class NotificationHandler {
  static Timer? _timer;
  static getNotification() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      getIt<NotificationProvider>().getNotifications();
    });
  }

  static stopNotification() {
    _timer?.cancel();
  }
}
