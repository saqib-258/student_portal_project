import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:student_portal/shared/global.dart';

class StudentFeeDetailApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, String>> getFeeStatus(String regNo) async {
    try {
      String url = '$endPoint/admin/GetFeeStatus?reg_no=$regNo';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, bool>> approveInstallment(
      String challanId) async {
    try {
      String url =
          'http://$ip/StudentPortal/api/Admin/ApproveFee?challanId=$challanId';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        return right(true);
      } else {
        return right(false);
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
