import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/student/models/core/attendance.dart';
import 'package:student_portal/student/models/helper/attendance_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class AttendanceProvider with ChangeNotifier {
  final _helper = AttendanceHelper();
  Either<Glitch, List<AttendanceModel>?>? result;
  List<AttendanceModel>? attendanceList;

  Future<void> getTimeTable() async {
    result = await _helper.getAttendance();
    attendanceList = result?.foldRight(attendanceList, (r, previous) => r);
    notifyListeners();
  }

  Future<bool?> contestAttendace(
      List<AttendanceContest> cList, String courseCode, int eid) async {
    Either<Glitch, bool?>? result =
        await _helper.contestAttendace(cList, courseCode, eid);
    bool? isDone;
    isDone = result?.foldRight(isDone, (r, previous) => r);
    return isDone;
  }
}
