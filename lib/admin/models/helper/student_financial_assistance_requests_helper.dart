import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:student_portal/admin/models/core/student_financial_assistance_request.dart';
import 'package:student_portal/admin/models/services/student_financial_assistance_requests_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class StudentFinancialAssistanceRequestsHelper {
  final api = StudentFinancialAssistanceRequestsApi();

  Future<Either<Glitch, List<StudentFinancialAssistanceRequest>?>?>
      getRequests() async {
    final apiResult = await api.getRequests();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<StudentFinancialAssistanceRequest> sList =
            StudentFinancialAssistanceRequest.fromJson(r);
        return Right(sList);
      }
    });
  }

  Future<Either<Glitch, List<String>?>?> getImages(int id) async {
    final apiResult = await api.getImages(id);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<String> sList =
            (jsonDecode(r) as List<dynamic>).map((e) => e as String).toList();
        return Right(sList);
      }
    });
  }
}
