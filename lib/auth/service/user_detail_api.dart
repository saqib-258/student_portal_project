import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../shared/global.dart';

class UserDetailApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> getUserDetail(
      String username, String role) async {
    try {
      String url = '$endPoint/Auth/GetUser?username=$username&role=$role';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      return Right(response.body);
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
