import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class GetStudentsApi {
  String endPoint = "http://$ip/StudentPortal/api";

  Future<Either<Exception, String>> getStudents() async {
    try {
      String url = '$endPoint/Admin/GetStudents';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
