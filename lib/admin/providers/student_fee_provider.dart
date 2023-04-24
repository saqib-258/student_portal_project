import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/core/student_fee.dart';
import 'package:student_portal/admin/models/helper/student_fee_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class StudentFeeProvider with ChangeNotifier {
  final _helper = StudentFeeHelper();
  Either<Glitch, List<StudentFee>?>? result;

  List<StudentFee>? sList;

  Future<void> getFeeStudents() async {
    result = await _helper.getFeeStudents();
    sList = result?.foldRight(sList, (r, previous) => r);
    notifyListeners();
  }
}
