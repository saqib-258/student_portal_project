import 'package:dartz/dartz.dart';
import 'package:student_portal/admin/models/core/student_fine.dart';
import 'package:student_portal/admin/models/services/student_fine_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class StudentFineHelper {
  final api = StudentFineApi();
  Future<Either<Glitch, List<StudentFine>?>?> getFineList() async {
    final apiResult = await api.getFineList();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<StudentFine> sList = StudentFine.fromJson(r);
        return Right(sList);
      }
    });
  }
}
