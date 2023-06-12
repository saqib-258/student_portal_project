import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_portal/auth/helper/auth_helper.dart';
import 'package:student_portal/auth/login_shred_pref.dart';
import 'package:student_portal/auth/model/user.dart';
import 'package:student_portal/auth/screen/login_screen.dart';
import 'package:student_portal/notification/notification_handler.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/utils/common.dart';

class AuthProvider with ChangeNotifier {
  final _helper = LoginHelper();
  bool isLoading = false;
  User? u;
  Either<Glitch, User?>? user;

  Future<void> loginUser(String username, String password) async {
    isLoading = true;
    notifyListeners();
    user = await _helper.loginUser(username, password);
    u = user!.foldRight(u, (r, previous) => u);
    isLoading = false;
    notifyListeners();
  }

  void logoutUser(BuildContext context) {
    getIt<LoginSharedPreferences>().logout();
    navigateAndOffAll(context, LoginScreen());
    NotificationHandler.stopNotification();
  }
}
