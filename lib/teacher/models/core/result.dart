import 'package:student_portal/teacher/models/core/student_enrollment.dart';

class Result extends StudentEnrollment {
  double obtainedMarks;
  double totalMarks;
  Result(
      {this.obtainedMarks = 0,
      this.totalMarks = 0,
      required super.eid,
      required super.name,
      required super.regNo,
      super.profilePhoto});
}
