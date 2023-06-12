import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_portal/auth/model/user.dart';

class LoginSharedPreferences {
  SharedPreferences? _prefs;

  static const String _lastLoginKey = 'loginVal';

  LoginSharedPreferences() {
    _init();
  }

  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<User?>? getLastLoginValue() async {
    await _init();
    String? data = _prefs!.getString(_lastLoginKey);
    if (data != null) {
      var u = jsonDecode(data);
      return User(role: u['role'], username: u['username']);
    }
    return null;
  }

  Future<void> setLastLoginValue(User user) async {
    await _init();
    await _prefs!.setString(_lastLoginKey,
        jsonEncode({"role": user.role, "username": user.username}));
  }

  Future<void> logout() async {
    await _init();
    await _prefs!.remove(_lastLoginKey);
  }
}
