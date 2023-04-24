import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class StudentFeeApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, String>> getFeeStudents() async {
    try {
      String url = '$endPoint/Admin/GetFeeStudents';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
