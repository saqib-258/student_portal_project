import 'package:dartz/dartz.dart';
import 'package:student_portal/admin/models/core/teacher_evaluation_course.dart';
import 'package:student_portal/admin/models/core/teacher_evaluation_result.dart';
import 'package:student_portal/admin/models/services/manage_teacher_evaluation_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class TeacherEvaluationResultHelper {
  final api = ManageTeacherEvaluationApi();
  Future<Either<Glitch, List<TeacherEvaluationCourse>?>?>
      getTeacherEvaluationCourses(String session) async {
    final apiResult = await api.getTeacherEvaluationCourses(session);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<TeacherEvaluationCourse> cList =
            TeacherEvaluationCourse.fromJson(r);
        return Right(cList);
      }
    });
  }

  Future<Either<Glitch, TeacherEvaluationResult?>?> getTeacherEvaluationResult(
      String session, String teacherId, String courseCode) async {
    final apiResult =
        await api.getTeacherEvaluation(session, teacherId, courseCode);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        TeacherEvaluationResult cList = TeacherEvaluationResult.fromJson(r);
        return Right(cList);
      }
    });
  }
}
