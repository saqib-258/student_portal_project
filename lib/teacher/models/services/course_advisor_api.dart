import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class CourseAdvisorApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getCourseAdvisor() async {
    try {
      String url =
          '$endPoint/Teacher/GetStudentsCourseAdvisor?teacher_id=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, bool?>> addCourseAdvisorDetail(
      Map<String, dynamic> map) async {
    try {
      String url =
          'http://$ip/StudentPortal/api/Teacher/AddCourseAdvisorDetail';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(map),
          headers: <String, String>{'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return const Right(false);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
