import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/teacher/models/core/result.dart';
import 'package:student_portal/teacher/models/helper/mark_result_helper.dart';
import 'package:student_portal/teacher/providers/student_enrollment_provider.dart';

class MarkResultProvider with ChangeNotifier {
  final _helper = MarkResultHelper();
  Either<Glitch, List<Result>?>? result;
  List<Result>? sList;

  Future<bool?> markResult(String? title, String type) async {
    Either<Glitch, bool?>? result;
    if (type == "quiz" || type == "assignment") {
      result = await _helper.markAssignmentQuiz(sList!, type, title!);
    } else {
      result = await _helper.markMidFinal(sList!, type);
    }
    bool? isDone;
    isDone = result?.foldRight(isDone, (r, previous) => r);
    return isDone;
  }

  Future<void> getStudents(String section, int id) async {
    final provider = StudentEnrollmentProvider();
    await provider.getStudents(section, id);
    sList = provider.sList!
        .map((e) => Result(eid: e.eid, name: e.name, regNo: e.regNo))
        .toList();
    notifyListeners();
  }
}
