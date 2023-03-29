import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class ManageTeacherEvaluationApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getTeacherEvaluationCourses(
      String session) async {
    try {
      String url = '$endPoint/Admin/GetAllTeachersAndCourses?session=$session';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getTeacherEvaluation(
      String session, String teacherId, String courseCode) async {
    try {
      String url =
          '$endPoint/Admin/GetTeacherFeedback?session=$session&teacherId=$teacherId&courseCode=$courseCode';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, bool>> startTeacherEvaluation(
      String startDate, String endDate) async {
    try {
      String url = '$endPoint/Admin/AllowAssessment';
      Uri uri = Uri.parse(url);
      final response = await post(uri,
          body: jsonEncode(
            {"start_date": startDate, "end_date": endDate},
          ),
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
