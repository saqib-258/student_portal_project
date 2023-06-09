import 'dart:convert';

import 'package:student_portal/teacher/models/core/course.dart';

class CourseAdvisor {
  int? id;
  String? section;
  String? program;
  int? semester;
  List<SList?>? sList;

  CourseAdvisor(
      {this.id, this.section, this.program, this.semester, this.sList});

  CourseAdvisor.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    section = json['section'];
    program = json['program'];
    semester = json['semester'];
    if (json['sList'] != null) {
      sList = <SList>[];
      json['sList'].forEach((v) {
        sList!.add(SList.fromJson(v));
      });
    }
  }
  static List<CourseAdvisor> fromJson(String jsonString) {
    return (jsonDecode(jsonString) as List<dynamic>)
        .map((map) => CourseAdvisor.fromMap(map))
        .toList();
  }
}

class SList {
  String? name;
  String? regNo;
  String? profilePhoto;
  double? cgpa;
  List<Course?>? regularcourses;
  List<Course?>? failedcourses;
  List<Course?>? remainingcourses;

  SList(
      {this.name,
      this.regNo,
      this.profilePhoto,
      this.cgpa,
      this.regularcourses,
      this.failedcourses,
      this.remainingcourses});

  SList.fromJson(Map<String, dynamic> json) {
    name = json['student_name'];
    regNo = json['reg_no'];
    profilePhoto = json['profile_pic'];
    cgpa = json['cgpa'];
    if (json['regular_courses'] != null) {
      regularcourses = <Course>[];
      json['regular_courses'].forEach((v) {
        regularcourses!.add(Course.fromJson(v));
      });
    }
    if (json['failed_courses'] != null) {
      failedcourses = <Course>[];
      json['failed_courses'].forEach((v) {
        failedcourses!.add(Course.fromJson(v));
      });
    }
    if (json['remaining_courses'] != null) {
      remainingcourses = <Course>[];
      json['remaining_courses'].forEach((v) {
        remainingcourses!.add(Course.fromJson(v));
      });
    }
  }
}
