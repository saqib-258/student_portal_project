import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/challan_detail.dart';
import 'package:student_portal/student/models/core/fee_detail.dart';
import 'package:student_portal/student/models/helper/fee_helper.dart';

class FeeProvider with ChangeNotifier {
  final _helper = FeeHelper();
  Either<Glitch, FeeDetail?>? result;
  Either<Glitch, String?>? result2;

  Either<Glitch, List<ChallanDetail>?>? result3;
  bool isGenerating = false;

  FeeDetail? feeDetail;
  List<ChallanDetail>? cList;
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

  Future<void> getFeeStatus() async {
    notifyListeners();
    result3 = await _helper.getFeeStatus();
    cList = result3?.foldRight(cList, (r, previous) => r);
    notifyListeners();
  }

  Future<void> getChallan() async {
    result2 = await _helper.getChallan();
    challanUrl = result2?.foldRight(challanUrl, (r, previous) => r);
  }

  Future<void> uploadChallan(File f, String id) async {
    result2 = await _helper.uploadChallan(f, id);
    ChallanDetail cd = cList!.where((element) => element.id == id).first;
    cd.challanImage = result2?.foldRight(cd.challanImage, (r, previous) => r);
  }
}
