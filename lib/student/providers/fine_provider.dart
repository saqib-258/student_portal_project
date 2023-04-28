import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/fine.dart';
import 'package:student_portal/student/models/helper/fine_helper.dart';

class FineProvider with ChangeNotifier {
  final _helper = FineHelper();
  Either<Glitch, List<Fine>?>? result;

  List<Fine>? fList;

  Future<void> getFineList() async {
    result = await _helper.getFineList();
    fList = result?.foldRight(fList, (r, previous) => r);
    notifyListeners();
  }
}
