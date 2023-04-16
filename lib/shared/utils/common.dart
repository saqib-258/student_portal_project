import 'package:flutter/material.dart';
import 'package:student_portal/shared/global.dart';

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
