import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:student_portal/admin/models/core/program_model.dart';
import 'package:student_portal/admin/models/helper/add_notice_board_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class AddNoticeBoardProvider with ChangeNotifier {
  final _helper = AddNoticeBoardHelper();
  Either<Glitch, List<ProgramModel>?>? result;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<ProgramModel>? pList;

  Future<void> getSectionList() async {
    result = await _helper.getSectionList();
    pList = result?.foldRight(pList, (r, previous) => r);
    notifyListeners();
  }
}
