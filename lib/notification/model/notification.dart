import 'dart:convert';

import 'package:student_portal/shared/utils/common.dart';

class NotificationModel {
  final int id;
  final String detail;
  final String dateTime;
  final String type;
  bool status;

  NotificationModel(
      {required this.id,
      required this.detail,
      required this.dateTime,
      required this.type,
      required this.status});

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
        id: map['id'],
        detail: map['detail'],
        dateTime: getTimeAgo(map['dateTime']),
        type: map['type'],
        status: map['status']);
  }
  static List<NotificationModel> fromJson(String jsonString) {
    return (jsonDecode(jsonString) as List<dynamic>)
        .map((map) => NotificationModel.fromMap(map))
        .toList();
  }
}
