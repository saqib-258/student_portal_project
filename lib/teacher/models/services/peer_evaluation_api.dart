import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class PeerEvaluationApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getEvaluationTeachersCourses() async {
    try {
      String url =
          '$endPoint/Teacher/GetEvaluatingTeachersCourses?teacher_id=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getPeerEvaluationQuestions() async {
    try {
      String url = '$endPoint/Teacher/GetPeerEvaluationQuestions';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, bool>> evaluatePeerTeacher(
      Map<String, dynamic> teacherEvaluationMap) async {
    try {
      String url = '$endPoint/Teacher/EvaluatePeerTeacher';
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
