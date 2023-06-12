import 'dart:io';

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
  List<File> images = [];
  List<Attendance>? sList;
  List<Contest>? cList;
  DateTime? selectedDate;
  String type = "class";

  void changeDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void removeContest(int index) {
    cList!.removeAt(index);
    notifyListeners();
  }

  void changeType(String val) {
    type = val;
    notifyListeners();
  }

  void addImage(File f) {
    images.add(f);
    notifyListeners();
  }

  void clearImages() {
    images.clear();
    notifyListeners();
  }

  Future<bool?> markAttendace(int allocationId) async {
    Either<Glitch, bool?>? result = await _helper.markAttendace(
        sList!, selectedDate.toString(), type, allocationId, images);
    bool? isDone;
    isDone = result?.foldRight(isDone, (r, previous) => r);
    return isDone;
  }

  Future<void> getStudents(String section, int id) async {
    final provider = getIt<StudentEnrollmentProvider>();
    await provider.getStudents(section, id);
    sList = provider.sList!
        .map((e) => Attendance(
            eid: e.eid,
            name: e.name,
            regNo: e.regNo,
            profilePhoto: e.profilePhoto))
        .toList();

    notifyListeners();
  }

  Future<void> getContests() async {
    contestResult = await _helper.getContests();
    cList = contestResult?.foldRight(cList, (r, previous) => r);
    notifyListeners();
  }

  void onMarkClick(int index) {
    if (sList![index].status == "A") {
      sList![index].status = 'P';
    } else {
      sList![index].status = 'A';
    }
    notifyListeners();
  }
}
