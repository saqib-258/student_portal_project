import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class FineApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getFineList() async {
    try {
      String url =
          '$endPoint/Student/GetFineList?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, String?>> uploadReceipt(
      File file, int id) async {
    try {
      String url = 'http://$ip/StudentPortal/api/Student/UploadFineReceipt';
      var request = MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = id.toString();
      MultipartFile newfile =
          await MultipartFile.fromPath('receipt', file.path);
      request.files.add(newfile);

      var result = await request.send();

      if (result.statusCode == 200) {
        var body = await result.stream.bytesToString();
        return Right(jsonDecode(body));
      } else {
        return const Right(null);
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
