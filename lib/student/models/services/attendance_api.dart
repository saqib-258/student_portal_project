import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/parent/model/children_model.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/global.dart';

class AttendaceApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getAttendance() async {
    try {
      String url =
          '$endPoint/Student/GetAttendance?reg_no=${getIt<ChildrenModel>().getRegNo ?? user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, bool>> contestAttendance(
      List<Map<String, dynamic>> contestMap) async {
    try {
      String url = '$endPoint/Student/ContestAttendance';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: json.encode(contestMap),
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

  Future<Either<Exception, String>> getAbsentList(int id) async {
    try {
      String url = '$endPoint/Student/GetAbsentList?eid=$id';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
