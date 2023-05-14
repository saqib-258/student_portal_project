import 'dart:convert';

class StudentFine {
  final int id;
  final String name;
  final String regNo;
  final String section;
  final String program;
  final int semester;
  final String? profilePhoto;
  final String date;
  String? receipt;
  final int amount;
  final String description;
  bool? status;

  StudentFine({
    required this.id,
    required this.name,
    required this.regNo,
    required this.section,
    required this.program,
    required this.semester,
    required this.profilePhoto,
    required this.date,
    required this.receipt,
    required this.amount,
    required this.description,
    required this.status,
  });

  factory StudentFine.fromMap(Map<String, dynamic> map) {
    return StudentFine(
      id: map['id'],
      name: map['name'],
      regNo: map['reg_no'],
      section: map['section'],
      program: map['program'],
      semester: map['semester'],
      profilePhoto: map['profile_photo'],
      date: map['date'],
      receipt: map['receipt'],
      amount: map['amount'],
      description: map['description'],
      status: map['status'],
    );
  }
  static List<StudentFine> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);

    return List<StudentFine>.from(
        data.map((studentJson) => StudentFine.fromMap(studentJson)));
  }
}
