import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_portal/shared/global.dart';
import 'package:timeago/timeago.dart' as timeago;

String getWeekDay(DateTime dateTime) {
  if (dateTime.weekday == 1) {
    return "Monday";
  } else if (dateTime.weekday == 2) {
    return "Tuesday";
  } else if (dateTime.weekday == 3) {
    return "Wednesday";
  } else if (dateTime.weekday == 4) {
    return "Thursday";
  } else if (dateTime.weekday == 5) {
    return "Friday";
  } else if (dateTime.weekday == 6) {
    return "Saturday";
  } else {
    return "Sunday";
  }
}

navigate(BuildContext context, Widget screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
navigateAndRepalce(BuildContext context, Widget screen) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
navigateAndOffAll(BuildContext context, Widget screen) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);

Future<void> navigateTo(BuildContext context, Widget screen) async =>
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
String getFileUrl(String folderName, String fileName) =>
    'http://$ip/StudentPortal/$folderName/$fileName';
String convertDateFormat(String date) {
  List<String> parts = date.split("-");
  return "${parts[2]}-${parts[1]}-${parts[0]}";
}

String getTimeAgo(String dateTimeString) {
  DateFormat dateFormat = DateFormat('dd-MM-yyyy,HH:mm:ss');
  DateTime dateTime = dateFormat.parse(dateTimeString);
  String timeAgo = timeago.format(dateTime);
  return timeAgo;
}
