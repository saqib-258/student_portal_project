import 'package:dartz/dartz.dart';
import 'package:student_portal/notification/model/notification.dart';
import 'package:student_portal/notification/service/notification_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class NotificationHelper {
  final api = NotificationApi();
  Future<Either<Glitch, List<NotificationModel>?>> getNotifications() async {
    final apiResult = await api.getNotifications();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<NotificationModel> cList = NotificationModel.fromJson(r);
        return Right(cList);
      }
    });
  }
}
