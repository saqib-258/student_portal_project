import 'package:dartz/dartz.dart';
import 'package:student_portal/admin/models/core/student_detail_model.dart';
import 'package:student_portal/admin/models/services/get_students_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class GetStudentsHelper {
  final api = GetStudentsApi();

  Future<Either<Glitch, List<StudentDetailModel>?>?> getStudents() async {
    final apiResult = await api.getStudents();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        List<StudentDetailModel> sList = StudentDetailModel.fromJson(r);
        return Right(sList);
      }
    });
  }
}
