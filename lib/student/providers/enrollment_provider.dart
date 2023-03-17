import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/enrollment_courses.dart';
import 'package:student_portal/student/models/helper/enrollment_helper.dart';

class EnrollmentProvider with ChangeNotifier {
  final _helper = EnrollmentHelper();
  Either<Glitch, EnrollmentCourses?>? result;
  EnrollmentCourses? cList;

  Future<void> getEnrollmentCourses() async {
    result = await _helper.getEnrollmentCourses();
    cList = result?.foldRight(cList, (r, previous) => r);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<bool?> getEnrollmentStatus() async {
    Either<Glitch, bool?> result = await _helper.getEnrollmentStatus();
    bool? status;
    status = result.foldRight(status, (r, previous) => r);
    return status;
  }

  Future<bool?> enrollCourses() async {
    Either<Glitch, bool?>? result = await _helper.enrollCourses(
        cList!.regularCourses, cList!.failedCourses);
    bool? isDone;
    isDone = result?.foldRight(isDone, (r, previous) => r);
    return isDone;
  }
}
