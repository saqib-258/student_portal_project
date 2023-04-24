import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/helper/student_fee_detail_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/challan_detail.dart';

class StudentFeeDetailProvider with ChangeNotifier {
  final _helper = StudentFeeDetailHelper();

  Either<Glitch, List<ChallanDetail>?>? result2;

  List<ChallanDetail>? cList;

  Future<void> getFeeStatus(String regNo) async {
    notifyListeners();
    result2 = await _helper.getFeeStatus(regNo);
    cList = result2?.foldRight(cList, (r, previous) => r);
    notifyListeners();
  }
}
