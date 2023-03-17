import 'dart:convert';

class EnrollmentCourses {
  List<RegularCourses> regularCourses;
  List<FailedCourses> failedCourses;
  EnrollmentCourses(
      {required this.regularCourses, required this.failedCourses});
  static EnrollmentCourses fromJson(String body) {
    dynamic result = jsonDecode(body) as dynamic;
    List<RegularCourses> rList = (result['enrollmentCourses'] as List<dynamic>)
        .map((e) => RegularCourses(
            courseCode: e['course_code'],
            courseName: e['course_name'],
            creditHours: e['credit_hours'],
            id: e['id'],
            section: e['section'],
            semester: e['semester'],
            program: e['program']))
        .toList();
    List<FailedCourses> fList = (result['failedCourses1'] as List<dynamic>)
        .map((e) => FailedCourses(
            courseCode: e['course_code'],
            courseName: e['course_name'],
            creditHours: e['credit_hours'],
            sections: (e['sections'] as List<dynamic>)
                .map((e) => EnrollmentCourseDetail(
                    id: e['id'],
                    section: e['section'],
                    semester: e['semester'],
                    program: e['program']))
                .toList()))
        .toList();
    return EnrollmentCourses(regularCourses: rList, failedCourses: fList);
  }
}

class RegularCourses extends EnrollmentCourseDetail {
  final String courseCode;
  final String courseName;
  final int creditHours;
  RegularCourses(
      {required this.courseCode,
      required this.courseName,
      required this.creditHours,
      required super.id,
      required super.section,
      required super.semester,
      required super.program});
}

class EnrollmentCourseDetail {
  final int id;
  final String section;
  final int semester;
  final String program;

  EnrollmentCourseDetail(
      {required this.id,
      required this.section,
      required this.semester,
      required this.program});
}

class FailedCourses {
  final String courseCode;
  final String courseName;
  final int creditHours;
  bool isSelected;
  String? selectedVal;
  List<EnrollmentCourseDetail> sections;
  FailedCourses(
      {this.isSelected = false,
      required this.courseCode,
      required this.courseName,
      required this.creditHours,
      required this.sections});
}
