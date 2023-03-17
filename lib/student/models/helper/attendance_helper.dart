import 'package:dartz/dartz.dart';
import 'package:student_portal/student/models/core/attendance.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/services/attendance_api.dart';

class AttendanceHelper {
  final api = AttendaceApi();
  Future<Either<Glitch, List<AttendanceModel>?>?> getAttendance() async {
    final apiResult = await api.getAttendance();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<AttendanceModel> attendance = AttendanceModel.fromJson(r);

        return Right(attendance);
      }
    });
  }

  Future<Either<Glitch, bool?>?> contestAttendace(
      List<AttendanceContest> cList, String courseCode, int eid) async {
    List<Map<String, dynamic>> contestMap = [];
    for (int i = 0; i < cList.length; i++) {
      if (cList[i].isChecked) {
        contestMap.add(
          {
            "attendance_id": cList[i].aid,
            "course_code": courseCode,
            "enrollment_id": eid
          },
        );
      }
    }
    final apiResult = await api.contestAttendance(contestMap);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
