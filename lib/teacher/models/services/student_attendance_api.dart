import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class StudentAttendanceApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, bool>> markAttendance(
      List<Map<String, dynamic>> attendanceMap) async {
    try {
      String url = '$endPoint/Teacher/MarkAttendance';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: json.encode(attendanceMap),
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
  Future<Either<Exception, bool>> acceptContest(
      int aid) async {
    try {
      String url = '$endPoint/Teacher/AcceptContest?aid=$aid';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri);
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(throw Exception("status code:${response.statusCode}"));
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }
  Future<Either<Exception, bool>> rejectContest(
      int aid) async {
    try {
      String url = '$endPoint/Teacher/RejectContest?aid=$aid';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri);
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(throw Exception("status code:${response.statusCode}"));
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getContests() async {
    try {
      String url =
          '$endPoint/Teacher/GetContests?username=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
