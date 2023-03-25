import 'dart:convert';

class TeacherEvaluationResult {
  final String question;
  final int percentage;
  TeacherEvaluationResult({
    required this.question,
    required this.percentage,
  });
  static List<TeacherEvaluationResult> fromJson(String body) {
    List<TeacherEvaluationResult> cList = [];
    cList = (jsonDecode(body) as List<dynamic>)
        .map((e) => TeacherEvaluationResult(
              question: e['question'],
              percentage: e['percentage'],
            ))
        .toList();
    return cList;
  }
}
