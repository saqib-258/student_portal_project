import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/student/models/core/challan_detail.dart';
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

  Future<Either<Glitch, String?>> getChallan() async {
    final apiResult = await api.getChallan();
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

  Future<Either<Glitch, String?>> uploadChallan(File f, String id) async {
    final apiResult = await api.uploadChallan(f, id);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        String challanImageUrl = jsonDecode(r);

        return Right(challanImageUrl);
      }
    });
  }

  Future<Either<Glitch, List<ChallanDetail>?>> getFeeStatus() async {
    final apiResult = await api.getFeeStatus();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<ChallanDetail> fList = ChallanDetail.fromJson(r);

        return Right(fList);
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
