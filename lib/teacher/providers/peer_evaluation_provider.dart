import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/teacher_course.dart';
import 'package:student_portal/student/models/core/teacher_evaluation_question.dart';

import 'package:student_portal/teacher/models/helper/peer_evaluation_helper.dart';

class PeerEvaluationProvider with ChangeNotifier {
  final _helper = PeerEvaluationHelper();
  Either<Glitch, List<TeacherCourse>?>? result;
  Either<Glitch, List<TeacherEvaluationQuestion>?>? questionsResult;
  List<TeacherEvaluationQuestion>? qList;

  List<TeacherCourse>? tList;

  Future<void> getEvaluationTeachersCourses() async {
    result = await _helper.getEvaluationTeachersCourses();
    tList = result?.foldRight(tList, (r, previou) => r);

    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<void> getTeacherEvaluationQuestions() async {
    questionsResult = await _helper.getTeacherEvaluationQuestions();
    qList = questionsResult?.foldRight(qList, (r, previous) => r);
    notifyListeners();
  }

  Future<bool?> evaluatePeerTeacher(int allocationID) async {
    Either<Glitch, bool?>? result =
        await _helper.evaluatePeerTeacher(qList!, allocationID);
    bool? isDone;
    isDone = result?.foldRight(isDone, (r, previous) => r);
    return isDone;
  }
}
