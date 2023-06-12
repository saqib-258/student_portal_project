import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/notification/helper/notification_helper.dart';
import 'package:student_portal/notification/model/notification.dart';
import 'package:student_portal/notification_service.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class NotificationProvider with ChangeNotifier {
  final _helper = NotificationHelper();
  Either<Glitch, List<NotificationModel>?>? result;

  List<NotificationModel>? notifications;

  Future<void> getNotifications() async {
    final previous =
        notifications == null ? [] : notifications!.map((e) => e.id).toList();
    result = await _helper.getNotifications();
    notifications = result?.foldRight(notifications, (r, previous) => r);
    final latest = notifications!.map((e) => e.id).toList();
    for (var element in notifications!) {
      if (previous.contains(element.id)) {
        latest.remove(element.id);
      }
    }
    if (latest.isNotEmpty) {
      if (notifications!.where((element) => !element.status).isEmpty) {
        return;
      }
      getIt<NotificationService>().showAppNotification(
          notifications!
              .where((element) => !element.status)
              .map((e) => e.detail)
              .toList(),
          "app_notification");
    }

    notifyListeners();
  }
}
