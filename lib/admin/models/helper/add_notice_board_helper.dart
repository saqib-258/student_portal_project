import 'package:dartz/dartz.dart';
import 'package:student_portal/admin/models/core/program_model.dart';
import 'package:student_portal/admin/models/services/add_notice_board_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class AddNoticeBoardHelper {
  final api = AddNoticeBoardApi();
  Future<Either<Glitch, List<ProgramModel>?>?> getSectionList() async {
    final apiResult = await api.getSectionList();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<ProgramModel> sList = ProgramModel.fromJson(r);
        return Right(sList);
      }
    });
  }
}
