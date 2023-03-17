import 'package:dartz/dartz.dart';
import 'package:student_portal/student/models/core/date_sheet.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/student/models/services/date_sheet_api.dart';

class DateSheetHelper {
  final api = DateSheetApi();
  Future<Either<Glitch, DateSheet?>?> getDateSheet() async {
    final apiResult = await api.getDateSheet();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        DateSheet dateSheet = DateSheet.fromJson(r);

        return Right(dateSheet);
      }
    });
  }
}
