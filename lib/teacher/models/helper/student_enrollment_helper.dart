import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/teacher/models/core/student_enrollment.dart';
import 'package:student_portal/teacher/models/services/student_enrollment_api.dart';

class StudentEnrollmentHelper {
  final api = StudentEnrollmentApi();
  Future<Either<Glitch, List<StudentEnrollment>?>?> getStudents(
      String section, int id) async {
    final apiResult = await api.getStudents(section, id);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      List<StudentEnrollment> cList = StudentEnrollment.fromJson(r);
      return Right(cList);
    });
  }
}
