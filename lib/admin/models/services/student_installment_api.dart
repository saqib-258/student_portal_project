import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class StudentInstallmentApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, String>> getInstallmentRequests() async {
    try {
      String url = '$endPoint/Admin/GetInstallmentRequests';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, bool>> acceptInstallmentRequest(
      int id) async {
    try {
      String url =
          'http://$ip/StudentPortal/api/Student/AcceptInstallmentRequest?id=$id';
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

  static Future<Either<Exception, bool>> rejectInstallmentRequest(
      int id) async {
    try {
      String url =
          'http://$ip/StudentPortal/api/Admin/RejectInstallmentRequest?id=$id';
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
}
