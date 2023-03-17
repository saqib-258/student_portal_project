import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/teacher_course.dart';
import 'package:student_portal/student/models/core/teacher_evaluation_question.dart';
import 'package:student_portal/student/models/helper/teacher_evaluation_helper.dart';

class TeacherEvaluationProvider with ChangeNotifier {
  final _helper = TeacherEvaluationHelper();
  Either<Glitch, List<TeacherCourse>?>? result;
  Either<Glitch, List<TeacherEvaluationQuestion>?>? questionsResult;

  List<TeacherCourse>? cList;
  List<TeacherEvaluationQuestion>? qList;

  Future<void> getCourseAndTeachers() async {
    result = await _helper.getCourseAndTeachers();
    cList = result?.foldRight(cList, (r, previous) => r);
    notifyListeners();
    getTeacherEvaluationQuestions();
  }

  void clearAnswers() {
    for (var v in qList!) {
      v.answer = null;
    }
    notifyListeners();
  }

  void changeAnswer() {
    notifyListeners();
  }

  Future<void> getTeacherEvaluationQuestions() async {
    questionsResult = await _helper.getTeacherEvaluationQuestions();
    qList = questionsResult?.foldRight(qList, (r, previous) => r);
    notifyListeners();
  }

  Future<bool?> feedbackTeacher(int allocationID) async {
    Either<Glitch, bool?>? result =
        await _helper.feedbackTeacher(qList!, allocationID);
    bool? isDone;
    isDone = result?.foldRight(isDone, (r, previous) => r);
    return isDone;
  }
}
