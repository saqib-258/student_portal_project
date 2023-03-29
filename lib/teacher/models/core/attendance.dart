import 'package:student_portal/teacher/models/core/student_enrollment.dart';

class Attendance extends StudentEnrollment {
  String status;
  Attendance(
      {this.status = "P",
      required super.eid,
      required super.name,
      required super.regNo,
      super.profilePhoto});
}
