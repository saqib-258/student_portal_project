import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:student_portal/shared/global.dart';

class AddCourseAllocationApi {
  String endPoint = "http://$ip/StudentPortal/api";
  Future<Either<Exception, String>> addCourseAllocation(File file) async {
    try {
      String url = '$endPoint/Admin/AddCourseAllocation';
      var request = MultipartRequest('POST', Uri.parse(url));
      MultipartFile newfile =
          await MultipartFile.fromPath('courseallocationfile', file.path);
      request.files.add(newfile);
      var result = await request.send();
      if (result.statusCode == 200) {
        return const Right("added");
      }
      return const Right("error");
    } on Exception catch (e) {
      return (Left(e));
    }
  }
}
