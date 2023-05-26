import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/course_advice.dart';
import 'package:student_portal/student/models/helper/get_advice_helper.dart';

class GetAdviceProvider with ChangeNotifier {
  final _helper = GetAdviceHelper();
  Either<Glitch, List<CourseAdvice>?>? result;

  List<CourseAdvice>? aList;

  Future<void> getAdviceList() async {
    result = await _helper.getAdviceList();
    aList = result?.foldRight(aList, (r, previous) => r);
    notifyListeners();
  }
}
