import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/teacher/models/core/student_enrollment.dart';
import 'package:student_portal/teacher/models/helper/student_enrollment_helper.dart';

class StudentEnrollmentProvider with ChangeNotifier {
  final _helper = StudentEnrollmentHelper();
  Either<Glitch, List<StudentEnrollment>?>? result;
  List<StudentEnrollment>? sList;
  Future<void> getStudents(String section, int id) async {
    result = await _helper.getStudents(section, id);
    sList = result?.foldRight(sList, (r, previous) => r);

    notifyListeners();
  }
}
