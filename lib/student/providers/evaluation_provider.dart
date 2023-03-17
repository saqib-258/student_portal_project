import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/evaluation.dart';
import 'package:student_portal/student/models/helper/evaluation_helper.dart';

class EvaluationProvider with ChangeNotifier {
  final _helper = EvaluationHelper();
  Either<Glitch, List<CourseEvaluation>?>? result1;
  Either<Glitch, List<ExamResult>?>? result2;
  Either<Glitch, List<String>?>? sessionResult;

  List<CourseEvaluation>? assignmentQuizMarks;
  List<ExamResult>? midFinalMarks;
  List<String>? sList = [];
  Future<void> getMySessions() async {
    sessionResult = await _helper.getMySessions();
    sList = sessionResult?.foldRight(sList, (r, previous) => r);
    notifyListeners();
  }

  Future<void> getAssignmentQuizMarks() async {
    result1 = await _helper.getAssignmentQuizMarks();
    assignmentQuizMarks =
        result1?.foldRight(assignmentQuizMarks, (r, previous) => r);
    notifyListeners();
  }

  Future<void> getMidFinalMarks(String session) async {
    result2 = await _helper.getMidFinalMarks(session);
    midFinalMarks = result2?.foldRight(midFinalMarks, (r, previous) => r);
    notifyListeners();
  }
}
