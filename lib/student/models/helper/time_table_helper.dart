import 'package:dartz/dartz.dart';
import 'package:student_portal/student/models/core/time_table.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/services/time_table_api.dart';

class TimeTableHelper {
  final api = TimeTableApi();
  Future<Either<Glitch, List<TimeTable>?>> getTimeTable() async {
    final apiResult = await api.getTimeTable();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<TimeTable> timeTableList = TimeTable.fromJson(r);

        return Right(timeTableList);
      }
    });
  }
}
