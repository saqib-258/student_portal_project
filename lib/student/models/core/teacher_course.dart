import 'dart:convert';

import 'package:student_portal/teacher/models/core/course.dart';

class TeacherCourse extends Course {
  final String teacherName;
  int id;
  bool isPending;
  TeacherCourse({
    required this.id,
    required this.teacherName,
    required super.courseCode,
    required super.courseName,
    required this.isPending,
  });
  static List<TeacherCourse> fromJson(String body) {
    List<TeacherCourse> tList = [];
    tList = (jsonDecode(body) as List<dynamic>)
        .map((e) => TeacherCourse(
            id: e['id'],
            isPending: e['isPending'],
            teacherName: e['teacherName'],
            courseCode: e['courseCode'],
            courseName: e['courseName']))
        .toList();
    return tList;
  }
}
