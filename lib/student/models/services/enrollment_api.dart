import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class EnrollmentApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getEnrollmentStatus() async {
    try {
      String url =
          '$endPoint/Student/GetEnrollmentStatus?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getEnrollmentCourses() async {
    try {
      String url =
          '$endPoint/Student/GetEnrollmentCourses?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, bool>> enrollCourses(
      List<Map<String, dynamic>> enrollmentMap) async {
    try {
      String url = '$endPoint/Student/EnrollCourses';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: json.encode(enrollmentMap),
          headers: <String, String>{'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(throw Exception("status code:${response.statusCode}"));
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
