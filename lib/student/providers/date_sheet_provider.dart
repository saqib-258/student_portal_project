import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/student/models/core/date_sheet.dart';
import 'package:student_portal/student/models/helper/date_sheet_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class DateSheetProvider with ChangeNotifier {
  final _helper = DateSheetHelper();
  Either<Glitch, DateSheet?>? result;
  DateSheet? dateSheet;

  Future<void> getDateSheet() async {
    result = await _helper.getDateSheet();
    dateSheet = result?.foldRight(dateSheet, (r, previous) => r);
    notifyListeners();
  }
}
