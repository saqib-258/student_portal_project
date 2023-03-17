import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class StudentEnrollmentApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getStudents(String section, int id) async {
    try {
      String url = '$endPoint/Teacher/GetStudents?section=$section&id=$id';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
