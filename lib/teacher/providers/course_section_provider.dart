import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/teacher/models/core/course.dart';
import 'package:student_portal/teacher/models/core/course_section.dart';
import 'package:student_portal/teacher/models/helper/courser_section_helper.dart';

class CourseSectionProvider with ChangeNotifier {
  final _helper = CourseSectionHelper();
  Either<Glitch, List<CourseSection>?>? result;

  List<CourseSection>? cList;

  List<Course>? courses;

  Set<String> _courseCodeSet = {};
  Future<void> getCourseSection() async {
    result = await _helper.getCourseSection();
    cList = result?.foldRight(cList, (r, previou) => r);
    _courseCodeSet = {};
    courses = [];
    for (int i = 0; i < cList!.length; i++) {
      if (_courseCodeSet.add(cList![i].courseCode)) {
        courses?.add(Course(
            courseCode: cList![i].courseCode,
            courseName: cList![i].courseName));
      }
    }
    notifyListeners();
  }
}
