import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/student/models/helper/time_table_helper.dart';
import 'package:student_portal/student/models/core/time_table.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class TimeTableProvider with ChangeNotifier {
  final _helper = TimeTableHelper();
  Either<Glitch, List<TimeTable>?>? result;
  List<TimeTable>? timeTableList;

  Future<void> getTimeTable() async {
    result = await _helper.getTimeTable();
    timeTableList = result?.foldRight(timeTableList, (r, previous) => r);
    notifyListeners();
  }
}
