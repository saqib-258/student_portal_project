import 'dart:convert';

class StudentEnrollment {
  int eid;
  String regNo;
  String name;
  StudentEnrollment(
      {required this.eid, required this.name, required this.regNo});
  static List<StudentEnrollment> fromJson(String body) {
    List<StudentEnrollment> aList;

    aList = List.of(jsonDecode(body) as List<dynamic>)
        .map((e) => StudentEnrollment(
              eid: e['id'],
              name: e['name'],
              regNo: e['reg_no'],
            ))
        .toList();
    return aList;
  }
}
