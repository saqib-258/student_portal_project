import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/teacher/models/core/course_section.dart';
import 'package:student_portal/teacher/models/services/course_section_api.dart';

class CourseSectionHelper {
  final api = CourseSectionApi();
  Future<Either<Glitch, List<CourseSection>?>?> getCourseSection() async {
    final apiResult = await api.getCourseSection();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<CourseSection> cList = CourseSection.fromJson(r);
        return Right(cList);
      }
    });
  }
}
