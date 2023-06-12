import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/student/models/core/attendance.dart';
import 'package:student_portal/student/models/helper/attendance_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class AttendanceProvider with ChangeNotifier {
  final _helper = AttendanceHelper();
  Either<Glitch, List<AttendanceModel>?>? result;
  Either<Glitch, List<int>?>? absentResult;
  List<AttendanceModel>? attendanceList;
  List<int>? absentIds;

  Future<void> getTimeTable() async {
    result = await _helper.getAttendance();
    attendanceList = result?.foldRight(attendanceList, (r, previous) => r);
    notifyListeners();
  }

  Future<bool?> contestAttendace(
      int attendanceId, String courseCode, int eid) async {
    Either<Glitch, bool?>? result =
        await _helper.contestAttendace(attendanceId, courseCode, eid);
    bool? isDone;
    isDone = result?.foldRight(isDone, (r, previous) => r);
    return isDone;
  }

  Future<void> getAbsentList(int eid) async {
    absentResult = await _helper.getAbsentList(eid);
    absentIds = absentResult?.foldRight(absentIds, (r, previous) => r);
    notifyListeners();
  }
}
