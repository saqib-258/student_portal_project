import 'package:dartz/dartz.dart';
import 'package:student_portal/admin/models/core/student_fee.dart';
import 'package:student_portal/admin/models/services/student_fee_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class StudentFeeHelper {
  final api = StudentFeeApi();

  Future<Either<Glitch, List<StudentFee>?>?> getFeeStudents() async {
    final apiResult = await api.getFeeStudents();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<StudentFee> sList = StudentFee.fromJson(r);
        return Right(sList);
      }
    });
  }
}
