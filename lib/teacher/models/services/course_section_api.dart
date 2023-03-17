import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class CourseSectionApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getCourseSection() async {
    try {
      String url =
          '$endPoint/Teacher/GetCourses?username=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
