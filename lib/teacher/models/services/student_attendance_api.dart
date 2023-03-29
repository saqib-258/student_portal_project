import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class StudentAttendanceApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, bool>> markAttendance(
      List<Map<String, dynamic>> attendanceMap,
      String date,
      int allocationId,
      List<File> images) async {
    try {
      String url = '$endPoint/Teacher/MarkAttendance';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['allocationId'] = allocationId.toString();
      request.fields['dateTime'] = date.toString();
      request.fields['attendances'] = jsonEncode(attendanceMap);

      for (int i = 0; i < images.length; i++) {
        http.MultipartFile newfile =
            await http.MultipartFile.fromPath('image${i + 1}', images[i].path);
        request.files.add(newfile);
      }

      var result = await request.send();

      if (result.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(throw Exception("status code:${result.statusCode}"));
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, bool>> acceptContest(int aid) async {
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

  Future<Either<Exception, bool>> rejectContest(int aid) async {
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
