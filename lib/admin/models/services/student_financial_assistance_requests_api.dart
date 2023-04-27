import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class StudentFinancialAssistanceRequestsApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, String>> getRequests() async {
    try {
      String url = '$endPoint/Admin/GetFinancialAssistanceRequests';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getImages(int id) async {
    try {
      String url = '$endPoint/Admin/GetFinancialAssistanceImages?id=$id';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<Either<Exception, bool>> acceptFinancialAssistanceRequest(
      int id) async {
    try {
      String url =
          'http://$ip/StudentPortal/api/Admin/AcceptFinancialAssistanceRequest?id=$id';
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

  static Future<Either<Exception, bool>> rejectFinancialAssistanceRequest(
      int id) async {
    try {
      String url =
          'http://$ip/StudentPortal/api/Admin/RejectFinancialAssistanceRequest?id=$id';
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
