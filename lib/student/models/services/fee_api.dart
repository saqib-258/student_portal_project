import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/notification_service.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/global.dart';

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

  Future<void> downloadFile(String url, String fileName) async {
    try {
      var response = await http.get(Uri.parse(url));
      Directory dir = Directory('/storage/emulated/0/Download');
      var localPath = dir.path;
      final savedDir = Directory(localPath);
      String fullPath = "";
      await savedDir.create(recursive: true).then((value) async {
        fullPath = '$localPath/$fileName';
        int fileNumber = 0;
        while (await File(fullPath).exists()) {
          fileNumber++;
          fullPath = '$localPath/${fileName.replaceAll('.', '($fileNumber).')}';
        }
      });
      await File(fullPath).writeAsBytes(response.bodyBytes);
      getIt<NotificationService>().showNotification(
          "Download complete", fullPath.split('/').last, fullPath);
    } catch (e) {
      getIt<NotificationService>()
          .showNotification("Challan", "Download failed", "");
    }
  }
}
