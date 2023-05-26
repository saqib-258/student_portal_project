import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class GetAdviceApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getAdviceList() async {
    try {
      String url =
          '$endPoint/Student/GetAdvice?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
