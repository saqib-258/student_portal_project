import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:student_portal/auth/model/user.dart';
import 'package:student_portal/auth/service/login_api.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';

class LoginHelper {
  final api = LoginApi();
  Future<Either<Glitch, User?>> loginUser(
      String username, String password) async {
    final apiResult = await api.loginUser(username, password);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r == "\"\"") {
        return const Right(null);
      } else {
        Map<String, dynamic> user = jsonDecode(r);
        return Right(User.fromMap(user));
      }
    });
  }
}
