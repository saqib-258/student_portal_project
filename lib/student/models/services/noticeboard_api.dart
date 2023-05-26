import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class NoticeboardApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getNoticeboardList() async {
    try {
      String url =
          '$endPoint/Student/GetNoticeBoardInformation?reg_no=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
