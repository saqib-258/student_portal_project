import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/teacher/models/core/attendance.dart';
import 'package:student_portal/teacher/models/core/contest.dart';
import 'package:student_portal/teacher/models/helper/student_attendance_helper.dart';
import 'package:student_portal/teacher/providers/student_enrollment_provider.dart';

class StudentAttendanceProvider with ChangeNotifier {
  final _helper = StudentAttendanceHelper();
  Either<Glitch, List<Attendance>?>? result;
  Either<Glitch, List<Contest>?>? contestResult;
  List<Attendance>? sList;
  List<Contest>? cList;
  DateTime? selectedDate;
  String type = "class";

  void changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void changeType(String val) {
    type = val;
    notifyListeners();
  }

  Future<bool?> markAttendace() async {
    Either<Glitch, bool?>? result = await _helper.markAttendace(
        sList!, selectedDate.toString().split(' ')[0], type);
    bool? isDone;
    isDone = result?.foldRight(isDone, (r, previous) => r);
    return isDone;
  }

  Future<void> getStudents(String section, int id) async {
    final provider = getIt<StudentEnrollmentProvider>();
    await provider.getStudents(section, id);
    sList = provider.sList!
        .map((e) => Attendance(eid: e.eid, name: e.name, regNo: e.regNo))
        .toList();
    notifyListeners();
  }

  Future<void> getContests() async {
    contestResult = await _helper.getContests();
    cList = contestResult?.foldRight(cList, (r, previous) => r);
    notifyListeners();
  }

  void onMarkClick(bool val, int index) {
    if (val) {
      sList![index].status = 'P';
    } else {
      sList![index].status = 'A';
    }
    notifyListeners();
  }
}
