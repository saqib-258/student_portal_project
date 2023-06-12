import 'package:dartz/dartz.dart';
import 'package:student_portal/admin/models/core/student_installment.dart';
import 'package:student_portal/admin/models/services/student_installment_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class StudentInstallmentHelper {
  final api = StudentInstallmentApi();
  Future<Either<Glitch, List<StudentInstallment>?>?>
      getInstallmentRequests() async {
    final apiResult = await api.getInstallmentRequests();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<StudentInstallment> sList = StudentInstallment.fromJson(r);
        return Right(sList);
      }
    });
  }
}
