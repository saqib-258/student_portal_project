import 'dart:convert';

class TeacherEvaluationCourse {
  final String teacherId;
  final String teacherName;
  final String courseName;
  final String courseCode;
  TeacherEvaluationCourse(
      {required this.teacherId,
      required this.teacherName,
      required this.courseName,
      required this.courseCode});
  static List<TeacherEvaluationCourse> fromJson(String body) {
    List<TeacherEvaluationCourse> cList = [];
    cList = (jsonDecode(body) as List<dynamic>)
        .map((e) => TeacherEvaluationCourse(
            teacherId: e['teacher_id'],
            teacherName: e['teacherName'],
            courseName: e['course_name'],
            courseCode: e['course_code']))
        .toList();
    return cList;
  }
}
