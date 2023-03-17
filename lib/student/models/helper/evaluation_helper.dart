import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/core/evaluation.dart';
import 'package:student_portal/student/models/services/evaluation_api.dart';

class EvaluationHelper {
  final api = EvaluationApi();
  Future<Either<Glitch, List<CourseEvaluation>?>?>
      getAssignmentQuizMarks() async {
    final apiResult = await api.getAssignmentQuizMarks();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<CourseEvaluation> evaluation = CourseEvaluation.fromJson(r);

        return Right(evaluation);
      }
    });
  }

  Future<Either<Glitch, List<ExamResult>?>?> getMidFinalMarks(
      String session) async {
    final apiResult = await api.getMidFinalMarks(session);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<ExamResult> examResult = ExamResult.fromJson(r);

        return Right(examResult);
      }
    });
  }

  Future<Either<Glitch, List<String>?>?> getMySessions() async {
    final apiResult = await api.getMySessions();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<String> examResult =
            (jsonDecode(r) as List<dynamic>).map((e) => e.toString()).toList();
        return Right(examResult);
      }
    });
  }
}
