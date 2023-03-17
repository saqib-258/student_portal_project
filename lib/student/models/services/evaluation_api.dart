import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';

class EvaluationApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getAssignmentQuizMarks() async {
    try {
      String url =
          '$endPoint/Student/GetAssignmentQuizMarks?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getMySessions() async {
    try {
      String url =
          '$endPoint/Student/GetMySessions?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getMidFinalMarks(String session) async {
    try {
      String url =
          '$endPoint/Student/GetMidFinalMarks?reg_no=${user.userDetail!.username}&session=$session';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
