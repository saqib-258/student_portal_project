import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/teacher/models/core/result.dart';
import 'package:student_portal/teacher/models/services/mark_result_api.dart';

class MarkResultHelper {
  final api = MarkResultApi();

  Future<Either<Glitch, bool?>?> markAssignmentQuiz(
      List<Result> aList, String type, String title) async {
    List<Map<String, dynamic>> marksMap = [];
    for (int i = 0; i < aList.length; i++) {
      marksMap.add({
        "enrollment_id": aList[i].eid,
        "type": type,
        "obtained_marks": aList[i].obtainedMarks,
        "total_marks": aList[i].totalMarks,
        "title": title
      });
    }
    final apiResult = await api.markAssignmentQuiz(marksMap);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      return Right(r);
    });
  }

  Future<Either<Glitch, bool?>?> markMidFinal(
      List<Result> aList, String type) async {
    List<Map<String, dynamic>> marksMap = [];
    for (int i = 0; i < aList.length; i++) {
      marksMap.add({
        "enrollment_id": aList[i].eid,
        "type": type,
        "obtained_marks": aList[i].obtainedMarks,
        "total_marks": aList[i].totalMarks,
      });
    }
    final apiResult = await api.markMidFinal(marksMap);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
