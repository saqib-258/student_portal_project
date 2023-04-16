import 'dart:convert';

class FeeDetail {
  int semesterFee;
  int extraCourseFee;
  int otherFee;
  int enrolledCoursesCount;
  bool isChallanGenerated;
  int admissionFee;
  FeeDetail(
      {required this.admissionFee,
      required this.semesterFee,
      required this.extraCourseFee,
      required this.enrolledCoursesCount,
      required this.isChallanGenerated,
      required this.otherFee});

  static FeeDetail fromJson(String body) {
    dynamic data = jsonDecode(body) as dynamic;
    return FeeDetail(
        admissionFee: data['admissionFee'],
        semesterFee: data['semesterFee'],
        extraCourseFee: data['extraCourseFee'],
        enrolledCoursesCount: data['enrolledCoursesCount'],
        isChallanGenerated: data['isChallanGenerated'],
        otherFee: data['otherFee']);
  }
}
