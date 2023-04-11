import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';
import 'package:path_provider/path_provider.dart';

class FeeApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getFeeDetail() async {
    try {
      String url =
          '$endPoint/Student/GetFeeDetail?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> generateChallan(
      Map<String, dynamic> map) async {
    try {
      String url = '$endPoint/Student/GenerateChallan';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(map),
          headers: <String, String>{'Content-Type': 'application/json'});
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
