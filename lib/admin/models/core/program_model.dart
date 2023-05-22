import 'dart:convert';

class ProgramModel {
  String program;
  bool isSelected;
  List<SemesterModel> semesters;
  ProgramModel(
      {required this.program,
      required this.semesters,
      this.isSelected = false});
  factory ProgramModel.fromMap(Map<String, dynamic> map) {
    return ProgramModel(
      program: map['program'],
      semesters: List<SemesterModel>.from(
          map['semesters'].map((semester) => SemesterModel.fromMap(semester))),
    );
  }
  static List<ProgramModel> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<ProgramModel>.from(
        data.map((json) => ProgramModel.fromMap(json)));
  }
}

class SemesterModel {
  int semester;
  List<SectionModel> sections;
  bool isSelected;
  SemesterModel(
      {required this.semester,
      required this.sections,
      this.isSelected = false});
  factory SemesterModel.fromMap(Map<String, dynamic> map) {
    return SemesterModel(
      semester: map['no'],
      sections: (map['sections'] as List<dynamic>)
          .map((e) => SectionModel(isSelected: false, section: e))
          .toList(),
    );
  }
}

class SectionModel {
  String section;
  bool isSelected;
  SectionModel({required this.isSelected, required this.section});
}
