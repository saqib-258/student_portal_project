import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/fee_detail.dart';
import 'package:student_portal/student/models/helper/fee_helper.dart';

class FeeProvider with ChangeNotifier {
  final _helper = FeeHelper();
  Either<Glitch, FeeDetail?>? result;
  Either<Glitch, String?>? result2;
  bool isGenerating = false;

  FeeDetail? feeDetail;
  String? challanUrl;

  Future<void> getFeeDetail() async {
    result = await _helper.getFeeDetail();
    feeDetail = result?.foldRight(feeDetail, (r, previous) => r);
    notifyListeners();
  }

  Future<void> generateChallan(List<int> installments) async {
    isGenerating = true;
    notifyListeners();
    result2 = await _helper.generateChallan(feeDetail!, installments);
    challanUrl = result2?.foldRight(challanUrl, (r, previous) => r);
    isGenerating = false;
    if (challanUrl != null) {
      feeDetail!.isChallanGenerated = true;
    }
    notifyListeners();
  }
}
