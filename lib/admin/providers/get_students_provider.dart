import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/core/student_detail_model.dart';
import 'package:student_portal/admin/models/helper/get_students_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class GetStudentsProvider with ChangeNotifier {
  final _helper = GetStudentsHelper();
  Either<Glitch, List<StudentDetailModel>?>? result;

  List<StudentDetailModel>? sList;

  Future<void> getStudents() async {
    result = await _helper.getStudents();
    sList = result?.foldRight(sList, (r, previous) => r);
    notifyListeners();
  }
}
