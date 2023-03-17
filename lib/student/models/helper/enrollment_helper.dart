import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:student_portal/shared/glitch/glitch.dart';
import 'package:student_portal/shared/glitch/no_internet_glitch.dart';
import 'package:student_portal/shared/global.dart';
import 'package:student_portal/student/models/core/enrollment_courses.dart';
import 'package:student_portal/student/models/services/enrollment_api.dart';

class EnrollmentHelper {
  final api = EnrollmentApi();
  Future<Either<Glitch, bool?>> getEnrollmentStatus() async {
    final apiResult = await api.getEnrollmentStatus();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        bool status = jsonDecode(r);

        return Right(status);
      }
    });
  }

  Future<Either<Glitch, EnrollmentCourses?>?> getEnrollmentCourses() async {
    final apiResult = await api.getEnrollmentCourses();
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      if (r.isEmpty) {
        return const Right(null);
      } else {
        EnrollmentCourses courses = EnrollmentCourses.fromJson(r);
        return Right(courses);
      }
    });
  }

  Future<Either<Glitch, bool?>?> enrollCourses(
      List<RegularCourses> rList, List<FailedCourses> fList) async {
    List<Map<String, dynamic>> eList = [];
    for (int i = 0; i < rList.length; i++) {
      eList.add({
        "course_offering_semester_id": rList[i].id,
        "section": rList[i].section,
        "reg_no": user.userDetail!.username
      });
    }
    for (int i = 0; i < fList.length; i++) {
      if (fList[i].isSelected) {
        eList.add({
          "course_offering_semester_id":
              int.parse(fList[i].selectedVal!.split('-')[0]),
          "section": fList[i].selectedVal!.split('-')[1],
          "reg_no": user.userDetail!.username
        });
      }
    }
    final apiResult = await api.enrollCourses(eList);
    return apiResult.fold((l) {
      return Left(NoInternetGlitch());
    }, (r) {
      return Right(r);
    });
  }
}
