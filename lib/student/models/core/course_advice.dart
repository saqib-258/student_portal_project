import 'dart:convert';

class CourseAdvice {
  String? teacherName;
  String? advice;

  CourseAdvice({required this.teacherName, required this.advice});

  factory CourseAdvice.fromMap(Map<String, dynamic> json) {
    return CourseAdvice(teacherName: json['name'], advice: json['advise']);
  }
  static List<CourseAdvice> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<CourseAdvice>.from(
        data.map((map) => CourseAdvice.fromMap(map)));
  }
}
