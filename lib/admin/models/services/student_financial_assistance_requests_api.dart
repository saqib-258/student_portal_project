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
}
