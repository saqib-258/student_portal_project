import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class NotificationApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getNotifications() async {
    try {
      String url =
          '$endPoint/Notification/GetNotifications?username=${user.userDetail!.username}';
      Uri uri = Uri.parse(url);
      final response = await get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }

  static Future<void> seenNotification(int id) async {
    try {
      String url =
          'http://$ip/StudentPortal/api/Notification/SeenNotification?id=$id';
      Uri uri = Uri.parse(url);
      await post(uri);
      // ignore: empty_catches
    } on Exception {}
  }
}
