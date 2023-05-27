import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_portal/auth/model/user.dart';
import 'package:student_portal/auth/helper/user_detail_helper.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class UserDetailProvider with ChangeNotifier {
  final _helper = UserDetailHelper();
  UserDetail? userDetail;
  Either<Glitch, UserDetail?>? result;
  Future<void> getUser(String username, String role) async {
    result = await _helper.getUserDetail(username, role);
    userDetail = result?.foldRight(userDetail, (r, previous) => r);
    notifyListeners();
  }

  Future<void> loggedUser(String username) async {
    userDetail = UserDetail(username: username);
  }
}
