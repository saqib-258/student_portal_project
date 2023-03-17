import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/core/teacher_evaluation_course.dart';
import 'package:student_portal/admin/models/helper/teacher_evaluation_result_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class TeacherEvaluationResultProvider with ChangeNotifier {
  final _helper = TeacherEvaluationResultHelper();
  Either<Glitch, List<TeacherEvaluationCourse>?>? result;
  List<TeacherEvaluationCourse>? cList;
  List<String>? sessionsList;

  Future<void> getTeacherEvaluationCourse(String session) async {
    result = await _helper.getTeacherEvaluationCourses(session);
    cList = result?.foldRight(cList, (r, previous) => r);
    notifyListeners();
  }
}
