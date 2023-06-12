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

  Future<Either<Exception, bool>> requestAdmin(Map<String, dynamic> map) async {
    try {
      String url = '$endPoint/Student/InstallmentRequest';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(map),
          headers: <String, String>{'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return const Right(false);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getChallan() async {
    try {
      String url =
          '$endPoint/Student/GetChallan?regNo=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getFeeStatus() async {
    try {
      String url =
          '$endPoint/Student/GetFeeStatus?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);

      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> uploadChallan(File file, String id) async {
    try {
      String url = '$endPoint/Student/UploadChallan';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      http.MultipartFile newfile =
          await http.MultipartFile.fromPath('challan', file.path);
      request.files.add(newfile);
      request.fields["id"] = id;
      var result = await request.send();
      if (result.statusCode == 200) {
        var responce = await result.stream.bytesToString();
        return Right(responce);
      } else {
        return Left(throw Exception("status code:${result.statusCode}"));
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<void> downloadFile(String url, String fileName) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (Platform.isWindows) {
        await File("..\\challan.pdf").writeAsBytes(response.bodyBytes);

        return;
      }
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
