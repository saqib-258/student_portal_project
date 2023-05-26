import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/student/models/core/teacher_course.dart';
import 'package:student_portal/student/models/core/teacher_evaluation_question.dart';
import 'package:student_portal/teacher/models/services/peer_evaluation_api.dart';

class PeerEvaluationHelper {
  final api = PeerEvaluationApi();
  Future<Either<Glitch, List<TeacherCourse>?>?>
      getEvaluationTeachersCourses() async {
    final apiResult = await api.getEvaluationTeachersCourses();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<TeacherCourse> cList = TeacherCourse.fromJson(r);
        return Right(cList);
      }
    });
  }

  Future<Either<Glitch, List<TeacherEvaluationQuestion>?>>
      getTeacherEvaluationQuestions() async {
    final apiResult = await api.getPeerEvaluationQuestions();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<TeacherEvaluationQuestion> qList =
            TeacherEvaluationQuestion.fromJson(r);
        return Right(qList);
      }
    });
  }

  Future<Either<Glitch, bool?>?> evaluatePeerTeacher(
      List<TeacherEvaluationQuestion> aList, int allocationID) async {
    Map<String, dynamic> teacherEvaluationMap;
    List<Map<String, int>> answersMap = [];
    for (int i = 0; i < aList.length; i++) {
      answersMap.add({"questionId": aList[i].id, "answer": aList[i].answer!});
    }
    teacherEvaluationMap = {
      "allocationId": allocationID,
      "reg_no": user.userDetail?.username,
      "evaluationAnswers": answersMap
    };
    final apiResult = await api.evaluatePeerTeacher(teacherEvaluationMap);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
