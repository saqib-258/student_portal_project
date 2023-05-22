import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/teacher/models/core/course_advisor.dart';
import 'package:student_portal/teacher/models/services/course_advisor_api.dart';

class CourseAdvisorHelper {
  final api = CourseAdvisorApi();
  Future<Either<Glitch, List<CourseAdvisor>?>?> getCourseAdvisor() async {
    final apiResult = await api.getCourseAdvisor();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<CourseAdvisor> cList = CourseAdvisor.fromJson(r);
        return Right(cList);
      }
    });
  }
}
