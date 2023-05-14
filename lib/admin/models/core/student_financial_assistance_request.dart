import 'dart:convert';

class StudentFinancialAssistanceRequest {
  String name;
  String regNo;
  int id;
  String description;
  String program;
  int semester;
  String section;
  String? profilePhoto;
  bool? status;
  String date;

  StudentFinancialAssistanceRequest(
      {required this.name,
      required this.regNo,
      required this.id,
      required this.description,
      required this.program,
      required this.semester,
      required this.section,
      required this.profilePhoto,
      required this.date,
      required this.status});

  factory StudentFinancialAssistanceRequest.fromMap(Map<String, dynamic> map) {
    return StudentFinancialAssistanceRequest(
      name: map['name'],
      regNo: map['reg_no'],
      id: map['id'],
      description: map['description'],
      program: map['program'],
      semester: map['semester'],
      section: map['section'],
      profilePhoto: map['profile_photo'],
      status: map['status'],
      date: map['date'],
    );
  }
  static List<StudentFinancialAssistanceRequest> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<StudentFinancialAssistanceRequest>.from(data.map(
        (studentJson) =>
            StudentFinancialAssistanceRequest.fromMap(studentJson)));
  }
}
