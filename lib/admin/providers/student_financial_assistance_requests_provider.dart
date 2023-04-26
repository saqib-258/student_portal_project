import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/core/student_financial_assistance_request.dart';
import 'package:student_portal/admin/models/helper/student_financial_assistance_requests_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class StudentFinancialAssistanceRequestsProvider with ChangeNotifier {
  final _helper = StudentFinancialAssistanceRequestsHelper();
  Either<Glitch, List<StudentFinancialAssistanceRequest>?>? result;

  List<StudentFinancialAssistanceRequest>? sList;

  Future<void> getRequests() async {
    result = await _helper.getRequests();
    sList = result?.foldRight(sList, (r, previous) => r);
    notifyListeners();
  }
}
