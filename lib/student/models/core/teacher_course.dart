import 'dart:convert';
import 'package:student_portal/teacher/models/core/course.dart';

class TeacherFeedbackModel {
  String? endDate;
  List<TeacherCourse>? courses;
  TeacherFeedbackModel.fromJson(String body) {
    var data = (jsonDecode(body) as dynamic);
    if (data == "no-data") {
      endDate = "";
      courses = [];
    }
  else{
     endDate = data['endDate'];
    courses = TeacherCourse.fromMap(data['data']);
  }
   
  }
}

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
  static List<TeacherCourse> fromMap(List<dynamic> mapList) {
    List<TeacherCourse> tList = [];
    tList = mapList
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
