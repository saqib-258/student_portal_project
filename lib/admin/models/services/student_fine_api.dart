import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class StudentFineApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, String>> getFineList() async {
    try {
      String url = '$endPoint/Admin/GetFineList';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, bool>> acceptFine(int id) async {
    try {
      String url = 'http://$ip/StudentPortal/api/Admin/AcceptFine?id=$id';
      Uri uri = Uri.parse(url);
      final response = await post(uri);

      if (response.statusCode == 200) {
        return right(true);
      } else {
        return right(false);
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, bool>> rejectFine(int id) async {
    try {
      String url = 'http://$ip/StudentPortal/api/Admin/RejectFine?id=$id';
      Uri uri = Uri.parse(url);
      final response = await post(uri);

      if (response.statusCode == 200) {
        return right(true);
      } else {
        return right(false);
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, bool>> addFine(
      Map<String, dynamic> map) async {
    try {
      String url = 'http://$ip/StudentPortal/api/Admin/AddFine';
      Uri uri = Uri.parse(url);
      final response = await post(uri,
          body: jsonEncode(map),
          headers: <String, String>{'Content-Type': 'application/json'});

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
