import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/core/teacher_evaluation_course.dart';
import 'package:student_portal/admin/models/core/teacher_evaluation_result.dart';
import 'package:student_portal/admin/models/helper/teacher_evaluation_result_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class TeacherEvaluationResultProvider with ChangeNotifier {
  final _helper = TeacherEvaluationResultHelper();
  Either<Glitch, List<TeacherEvaluationCourse>?>? result;
  Either<Glitch, List<TeacherEvaluationResult>?>? result2;

  List<TeacherEvaluationCourse>? cList;
  List<TeacherEvaluationResult>? eList;

  List<String>? sessionsList;
  String? session;

  Future<void> getTeacherEvaluationCourse(String session) async {
    this.session = session;
    result = await _helper.getTeacherEvaluationCourses(session);
    cList = result?.foldRight(cList, (r, previous) => r);
    notifyListeners();
  }

  Future<void> getTeacherEvaluationResult(
      String teacherId, String courseCode) async {
    result2 = await _helper.getTeacherEvaluationResult(
        session!, teacherId, courseCode);
    eList = result2?.foldRight(eList, (r, previous) => r);
    notifyListeners();
  }
}
