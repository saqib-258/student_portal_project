import 'package:dartz/dartz.dart';
import 'package:student_portal/admin/models/services/student_fee_detail_api.dart';
import 'package:student_portal/student/models/core/challan_detail.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class StudentFeeDetailHelper {
  final api = StudentFeeDetailApi();

  Future<Either<Glitch, List<ChallanDetail>?>> getFeeStatus(
      String regNo) async {
    final apiResult = await api.getFeeStatus(regNo);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<ChallanDetail> fList = ChallanDetail.fromJson(r);

        return Right(fList);
      }
    });
  }
}
