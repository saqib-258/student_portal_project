import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/core/peer_evaluation_result.dart';
import 'package:student_portal/student/models/services/peer_evaluation_result_api.dart';

class PeerEvaluationResultHelper {
  final api = PeerEvaluationResultApi();
  Future<Either<Glitch, List<PeerEvaluationResult>?>>
      getPeerEvaluationResult() async {
    final apiResult = await api.getPeerEvaluationResult();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<PeerEvaluationResult> cList = PeerEvaluationResult.fromJson(r);
        return Right(cList);
      }
    });
  }
}
