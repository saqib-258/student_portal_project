import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/student/models/core/financial_assistance_images.dart';

class FinancialAssistanceApi {
  static Future<Either<Exception, bool>> requestFinancialAssistance(
      String description, List<FinancialAssistanceImages> images) async {
    try {
      String url =
          'http://$ip/StudentPortal/api/Student/RequestFinancialAssistance';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['description'] = description;
      request.fields['reg_no'] = user.userDetail!.username;

      for (int i = 0; i < images.length; i++) {
        http.MultipartFile newfile = await http.MultipartFile.fromPath(
            images[i].title, images[i].f.path);
        request.files.add(newfile);
      }

      var result = await request.send();

      if (result.statusCode == 200) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
