import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/parent/model/children_model.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/global.dart';

class EvaluationApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getAssignmentQuizMarks() async {
    try {
      String url =
          '$endPoint/Student/GetAssignmentQuizMarks?reg_no=${getIt<ChildrenModel>().getRegNo ?? user.userDetail!.username}';
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
          '$endPoint/Student/GetMySessions?reg_no=${getIt<ChildrenModel>().getRegNo ?? user.userDetail!.username}';
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
          '$endPoint/Student/GetMidFinalMarks?reg_no=${getIt<ChildrenModel>().getRegNo ?? user.userDetail!.username}&session=$session';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
