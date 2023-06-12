import 'dart:convert';

import 'package:student_portal/teacher/models/core/course_section.dart';

class Contest extends CourseSection {
  final String regNo;
  final String name;
  String status;
  final String date;
  final List<String> images;

  Contest(
      {required this.regNo,
      required this.name,
      required this.date,
      required super.id,
      required super.program,
      required super.section,
      required super.semester,
      required super.courseCode,
      required super.courseName,
      required this.status,
      required this.images});

  static List<Contest> fromJson(String body) {
    List<Contest> cList = [];
    cList = (jsonDecode(body) as List<dynamic>)
        .map((e) => Contest(
            images:
                (e['images'] as List<dynamic>).map((e) => e as String).toList(),
            id: e['attendance_id'],
            program: e['program'],
            section: e['section'],
            semester: e['semester'],
            courseCode: e['course_code'],
            courseName: e['course_name'],
            status: e['status'],
            date: e['dateTime'],
            name: e['name'],
            regNo: e['reg_no']))
        .toList();
    return cList;
  }
}
