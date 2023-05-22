import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/teacher/models/core/course_advisor.dart';
import 'package:student_portal/teacher/models/helper/course_advisor.dart';

class CourseAdvisorProvider with ChangeNotifier {
  final _helper = CourseAdvisorHelper();
  Either<Glitch, List<CourseAdvisor>?>? result;

  List<CourseAdvisor>? cList;

  Future<void> getCourseSection() async {
    result = await _helper.getCourseAdvisor();
    cList = result?.foldRight(cList, (r, previou) => r);

    notifyListeners();
  }
}
