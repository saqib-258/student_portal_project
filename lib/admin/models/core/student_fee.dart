import 'dart:convert';

class StudentFee {
  String name;
  String regNo;
  String section;
  String session;
  int semester;
  String? profilePhoto;
  String program;
  bool isPending;

  StudentFee({
    required this.name,
    required this.regNo,
    required this.section,
    required this.session,
    required this.semester,
    required this.profilePhoto,
    required this.program,
    required this.isPending,
  });

  factory StudentFee.fromMap(Map<String, dynamic> json) {
    return StudentFee(
      name: json['name'],
      regNo: json['regNo'],
      section: json['section'],
      session: json['session'],
      semester: json['semester'],
      profilePhoto: json['profilePhoto'],
      program: json['program'],
      isPending: json['isPending'],
    );
  }
  static List<StudentFee> fromJson(String body) {
    final List<dynamic> jsonList = jsonDecode(body);
    return jsonList.map((json) => StudentFee.fromMap(json)).toList();
  }
}
