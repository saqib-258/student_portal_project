import 'dart:convert';

import 'package:student_portal/teacher/models/core/course.dart';

class CourseSection extends Course {
  int id;
  String section;
  String program;
  int semester;
  int? allocationId;
  CourseSection(
      {required this.id,
      this.allocationId,
      required this.program,
      required this.section,
      required this.semester,
      required super.courseCode,
      required super.courseName});
  static List<CourseSection> fromJson(String body) {
    List<CourseSection> cList;
    cList = (jsonDecode(body) as List<dynamic>)
        .map((e) => CourseSection(
            id: e['id'],
            courseCode: e['course_code'],
            courseName: e['course_name'],
            section: e['section'],
            program: e['program'],
            allocationId: e['allocation_id'],
            semester: int.parse(e['semester'].toString())))
        .toList();
    return cList;
  }
}
