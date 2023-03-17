import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class MarkResultApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, bool>> markAssignmentQuiz(
      List<Map<String, dynamic>> marksMap) async {
    try {
      String url = '$endPoint/Teacher/MarkAssignmentQuiz';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: json.encode(marksMap),
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

  Future<Either<Exception, bool>> markMidFinal(
      List<Map<String, dynamic>> marksMap) async {
    try {
      String url = '$endPoint/Teacher/MarkMidFinal';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: json.encode(marksMap),
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
