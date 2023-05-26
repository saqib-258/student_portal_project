import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/core/noticeboard.dart';
import 'package:student_portal/student/models/services/noticeboard_api.dart';

class NoticeboardHelper {
  final api = NoticeboardApi();
  Future<Either<Glitch, List<Noticeboard>?>> getNoticeboardList() async {
    final apiResult = await api.getNoticeboardList();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<Noticeboard> cList = Noticeboard.fromJson(r);
        return Right(cList);
      }
    });
  }
}
