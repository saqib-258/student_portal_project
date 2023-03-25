import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_portal/auth/helper/login_helper.dart';
import 'package:student_portal/auth/model/user.dart';
import 'package:student_portal/shared/glitch/glitch.dart';

class LoginProvider with ChangeNotifier {
  final _helper = LoginHelper();
  bool isLoading = false;
  User? u;
  Either<Glitch, User?>? user;

  void updateLoadingStatus() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> loginUser(String username, String password) async {
    user = await _helper.loginUser(username, password);
    u = user!.foldRight(u, (r, previous) => u);
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }
}