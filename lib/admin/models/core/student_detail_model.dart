import 'dart:convert';

class StudentDetailModel {
  String regNo;
  String name;
  String? profilePhoto;
  int semester;
  String section;
  String program;
  String? session;
  StudentDetailModel(
      {required this.name,
      required this.profilePhoto,
      required this.program,
      required this.regNo,
      required this.section,
      required this.semester,
      required this.session});
  StudentDetailModel.fromMap(Map<String, dynamic> map)
      : regNo = map['reg_no'],
        name = map['name'],
        profilePhoto = map['profile_photo'],
        semester = map['semester'],
        section = map['section'],
        program = map['program'],
        session = map['session'];

  static List<StudentDetailModel> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<StudentDetailModel>.from(
        data.map((studentJson) => StudentDetailModel.fromMap(studentJson)));
  }
}
