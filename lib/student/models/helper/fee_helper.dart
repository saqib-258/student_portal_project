import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/student/models/core/fee_detail.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/services/fee_api.dart';

class FeeHelper {
  final api = FeeApi();

  Future<Either<Glitch, FeeDetail?>> getFeeDetail() async {
    final apiResult = await api.getFeeDetail();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        FeeDetail feeDetail = FeeDetail.fromJson(r);

        return Right(feeDetail);
      }
    });
  }

  Future<Either<Glitch, String?>> generateChallan(
      FeeDetail feeDetail, List<int> installments) async {
    Map<String, dynamic> map = {
      "regNo": user.userDetail!.username,
      "semesterFee": feeDetail.semesterFee,
      "admissionFee": feeDetail.admissionFee,
      "extraCourseFee": feeDetail.extraCourseFee,
      "otherFee": feeDetail.otherFee,
      "installmentAmount": installments
    };

    final apiResult = await api.generateChallan(map);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        String challanUrl = jsonDecode(r);

        return Right(challanUrl);
      }
    });
  }
}
