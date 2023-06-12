import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/teacher_course.dart';
import 'package:student_portal/student/models/core/teacher_evaluation_question.dart';
import 'package:student_portal/student/models/helper/teacher_evaluation_helper.dart';

class TeacherEvaluationProvider with ChangeNotifier {
  final _helper = TeacherEvaluationHelper();
  Either<Glitch, TeacherFeedbackModel?>? result;
  Either<Glitch, List<TeacherEvaluationQuestion>?>? questionsResult;

  TeacherFeedbackModel? model;
  List<TeacherEvaluationQuestion>? qList;

  Future<void> getCourseAndTeachers() async {
    result = await _helper.getCourseAndTeachers();
    model = result?.foldRight(model, (r, previous) => r);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<void> getTeacherEvaluationQuestions(int allocationId) async {
    questionsResult = await _helper.getTeacherEvaluationQuestions(allocationId);
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
