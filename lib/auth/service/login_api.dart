import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../shared/global.dart';

class LoginApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> loginUser(
      String username, String password) async {
    try {
      String url =
          '$endPoint/Auth/LoginUser?username=$username&password=$password';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
