import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:student_portal/auth/model/user.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/auth/service/user_detail_api.dart';

class UserDetailHelper {
  final api = UserDetailApi();
  Future<Either<Glitch, UserDetail?>>? getUserDetail(
      String username, String role) async {
    final apiResult = await api.getUserDetail(username, role);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        Map<String, dynamic> userDetail = jsonDecode(r) as Map<String, dynamic>;
        return Right(UserDetail.fromMap(userDetail));
      }
    });
  }
}
