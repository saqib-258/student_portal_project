import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/teacher/models/core/attendance.dart';
import 'package:student_portal/teacher/models/core/contest.dart';
import 'package:student_portal/teacher/models/services/student_attendance_api.dart';

class StudentAttendanceHelper {
  final api = StudentAttendanceApi();

  Future<Either<Glitch, List<Contest>?>?> getContests() async {
    final apiResult = await api.getContests();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<Contest> cList = Contest.fromJson(r);
        return Right(cList);
      }
    });
  }

  Future<Either<Glitch, bool?>?> markAttendace(
      List<Attendance> aList, String date, String type) async {
    List<Map<String, dynamic>> attendanceMap = [];
    for (int i = 0; i < aList.length; i++) {
      attendanceMap.add({
        "enrollment_id": aList[i].eid,
        "status": aList[i].status,
        "date": date,
        "type": type
      });
    }
    final apiResult = await api.markAttendance(attendanceMap);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
