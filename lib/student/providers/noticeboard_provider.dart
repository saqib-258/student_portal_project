import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/student/models/core/noticeboard.dart';
import 'package:student_portal/student/models/helper/noticeboard_helper.dart';

class NoticeboardProvider with ChangeNotifier {
  final _helper = NoticeboardHelper();
  Either<Glitch, List<Noticeboard>?>? result;

  List<Noticeboard>? aList;

  Future<void> getNoticeboardList() async {
    result = await _helper.getNoticeboardList();
    aList = result?.foldRight(aList, (r, previous) => r);
    notifyListeners();
  }
}
