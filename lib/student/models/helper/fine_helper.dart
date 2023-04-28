import 'package:dartz/dartz.dart';
import 'package:student_portal/student/models/core/fine.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/services/fine_api.dart';

class FineHelper {
  final api = FineApi();
  Future<Either<Glitch, List<Fine>?>> getFineList() async {
    final apiResult = await api.getFineList();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<Fine> cList = Fine.fromJson(r);
        return Right(cList);
      }
    });
  }
}
