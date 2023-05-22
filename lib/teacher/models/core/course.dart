class Course {
  String courseCode;
  String courseName;
  Course({required this.courseCode, required this.courseName});
  Course.fromJson(Map<String, dynamic> json)
      : courseName = json['course_name'],
        courseCode = json['course_code'];
}
