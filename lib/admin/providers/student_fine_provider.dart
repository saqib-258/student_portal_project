import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/core/student_fine.dart';
import 'package:student_portal/admin/models/helper/student_fine_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class StudentFineProvider with ChangeNotifier {
  final _helper = StudentFineHelper();
  Either<Glitch, List<StudentFine>?>? result;

  List<StudentFine>? fList;

  Future<void> getFineList() async {
    result = await _helper.getFineList();
    fList = result?.foldRight(fList, (r, previous) => r);
    notifyListeners();
  }
}
