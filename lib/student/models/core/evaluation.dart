import 'dart:convert';

class CourseEvaluation {
  final String courseCode;
  final String courseName;
  final int enrollmentId;
  final List<Evaluation> detail;
  CourseEvaluation(
      {required this.courseCode,
      required this.courseName,
      required this.detail,
      required this.enrollmentId});
  static List<CourseEvaluation> fromJson(String body) {
    List<CourseEvaluation> eList = [];
    eList = (jsonDecode(body) as List<dynamic>).map((e) {
      return CourseEvaluation(
          courseCode: e['courseCode'],
          courseName: e['courseName'],
          enrollmentId: e['enrollmentId'],
          detail: (e['detail'] as List<dynamic>)
              .map((e) => Evaluation(
                  title: e['title'],
                  type: e['type'],
                  obtainedmarks: e['obtained_marks'],
                  totalMarks: e['total_marks']))
              .toList());
    }).toList();
    return eList;
  }
}

class Evaluation extends ResultDetail {
  String title;

  Evaluation({
    required this.title,
    required super.type,
    required super.obtainedmarks,
    required super.totalMarks,
  });
}

class ExamResult extends ResultDetail {
  String courseCode;
  String courseName;
  int enrollmentId;
  ExamResult(
      {required this.courseCode,
      required this.courseName,
      required this.enrollmentId,
      required super.type,
      required super.obtainedmarks,
      required super.totalMarks});

  static List<ExamResult> fromJson(String body) {
    List<ExamResult> eList = [];
    eList = (jsonDecode(body) as List<dynamic>)
        .map((e) => ExamResult(
            courseCode: e['courseCode'],
            courseName: e['courseName'],
            enrollmentId: e['enrollmentId'],
            type: e['type'],
            obtainedmarks: e['obtained_marks'],
            totalMarks: e['total_marks']))
        .toList();
    return eList;
  }
}

class ResultDetail {
  final String type;
  final double totalMarks;
  final double obtainedmarks;
  ResultDetail(
      {required this.type,
      required this.obtainedmarks,
      required this.totalMarks});
}
