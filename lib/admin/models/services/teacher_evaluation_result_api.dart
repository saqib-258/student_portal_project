import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class TeacherEvaluationResultApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getTeacherEvaluationCourses(
      String session) async {
    try {
      String url = '$endPoint/Admin/GetAllTeachersAndCourses?session=$session';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
