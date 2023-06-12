import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/core/student_installment.dart';
import 'package:student_portal/admin/models/helper/student_installment_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class StudentInstallmentProvider with ChangeNotifier {
  final _helper = StudentInstallmentHelper();
  Either<Glitch, List<StudentInstallment>?>? result;

  List<StudentInstallment>? sList;

  Future<void> getInstallmentRequests() async {
    result = await _helper.getInstallmentRequests();
    sList = result?.foldRight(sList, (r, previous) => r);
    notifyListeners();
  }
}
