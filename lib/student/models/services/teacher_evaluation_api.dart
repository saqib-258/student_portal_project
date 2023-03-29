import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class TeacherEvaluationApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getCourseAndTeachers() async {
    try {
      String url =
          '$endPoint/Student/GetCourseAndTeachers?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getTeacherEvaluationQuestions(
      int allocationId) async {
    try {
      String url =
          '$endPoint/Student/GetTeacherEvaluationQuestions?allocationId=$allocationId';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, bool>> feedbackTeacher(
      Map<String, dynamic> teacherEvaluationMap) async {
    try {
      String url = '$endPoint/Student/FeedbackTeacher';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(teacherEvaluationMap),
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
