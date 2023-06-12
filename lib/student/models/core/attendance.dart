import 'dart:convert';

class AttendanceModel {
  String courseCode;
  String courseName;
  int enrollmentId;
  int presents = 0;
  int absents = 0;

  List<AttendanceDetailModel> detail;
  AttendanceModel(
      {required this.courseCode,
      required this.courseName,
      required this.detail,
      required this.enrollmentId});
  static List<AttendanceModel> fromJson(String body) {
    List<AttendanceModel> aList;
    aList = (jsonDecode(body) as List<dynamic>).map((e) {
      AttendanceModel a = AttendanceModel(
          courseCode: e['courseCode'],
          courseName: e['courseName'],
          enrollmentId: e['enrollmentId'],
          detail: (e['detail'] as List<dynamic>)
              .map((e) => AttendanceDetailModel(
                    status: e['status'],
                    date: e['date'],
                    type: e['type'],
                    aid: e['aid'],
                  ))
              .toList());
      for (int i = 0; i < a.detail.length; i++) {
        if (a.detail[i].status == "P") {
          a.presents++;
        } else {
          a.absents++;
        }
      }
      return a;
    }).toList();
    return aList;
  }
}

class AttendanceDetailModel {
  int aid;
  final String status;
  final String date;
  final String type;
  AttendanceDetailModel(
      {required this.aid,
      required this.status,
      required this.date,
      required this.type});
}
