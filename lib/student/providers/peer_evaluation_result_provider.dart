import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/peer_evaluation_result.dart';
import 'package:student_portal/student/models/helper/peer_evaluation_result_helper.dart';

class PeerEvaluationResultProvider with ChangeNotifier {
  final _helper = PeerEvaluationResultHelper();
  Either<Glitch, List<PeerEvaluationResult>?>? result;

  List<PeerEvaluationResult>? rList;

  Future<void> getPeerEvaluationResult() async {
    result = await _helper.getPeerEvaluationResult();
    rList = result?.foldRight(rList, (r, previous) => r);
    notifyListeners();
  }
}
