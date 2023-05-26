import 'dart:convert';

class PeerQuestionResult {
  String? question;
  List<Result?>? result;

  PeerQuestionResult({this.question, this.result});

  PeerQuestionResult.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }
}

class Result {
  String? teacherName;
  double? percentage;

  Result({this.teacherName, this.percentage});

  Result.fromJson(Map<String, dynamic> json) {
    teacherName = json['teacherName'];
    percentage = double.parse(json['percentage'].toString());
  }
}

class PeerEvaluationResult {
  String? courseCode;
  String? courseName;
  List<PeerQuestionResult?>? questionResult;
  List<Result?>? totalResult;

  PeerEvaluationResult(
      {this.courseCode,
      this.courseName,
      this.questionResult,
      this.totalResult});

  PeerEvaluationResult.fromMap(Map<String, dynamic> json) {
    courseCode = json['courseCode'];
    courseName = json['courseName'];
    if (json['questionResult'] != null) {
      questionResult = <PeerQuestionResult>[];
      json['questionResult'].forEach((v) {
        questionResult!.add(PeerQuestionResult.fromJson(v));
      });
    }
    if (json['totalResult'] != null) {
      totalResult = <Result>[];
      json['totalResult'].forEach((v) {
        totalResult!.add(Result.fromJson(v));
      });
    }
  }
  static List<PeerEvaluationResult> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<PeerEvaluationResult>.from(
        data.map((map) => PeerEvaluationResult.fromMap(map)));
  }
}
