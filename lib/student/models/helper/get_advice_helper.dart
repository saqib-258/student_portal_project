import 'package:dartz/dartz.dart';
import 'package:student_portal/student/models/core/course_advice.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/services/get_advice_api.dart';

class GetAdviceHelper {
  final api = GetAdviceApi();
  Future<Either<Glitch, List<CourseAdvice>?>> getAdviceList() async {
    final apiResult = await api.getAdviceList();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<CourseAdvice> cList = CourseAdvice.fromJson(r);
        return Right(cList);
      }
    });
  }
}
