import 'dart:convert';

class StudentEnrollment {
  int eid;
  String regNo;
  String name;
  String? profilePhoto;
  StudentEnrollment(
      {required this.eid,
      required this.name,
      required this.regNo,
      this.profilePhoto});
  static List<StudentEnrollment> fromJson(String body) {
    List<StudentEnrollment> aList;

    aList = List.of(jsonDecode(body) as List<dynamic>)
        .map((e) => StudentEnrollment(
            eid: e['id'],
            name: e['name'],
            regNo: e['reg_no'],
            profilePhoto: e['profile_photo']))
        .toList();

    return aList;
  }
}
