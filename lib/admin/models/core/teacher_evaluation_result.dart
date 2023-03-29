import 'dart:convert';

class TeacherEvaluationResult {
  final List<QuestionResult> questionResult;
  final TeacherEvaluationData evaluationData;
  TeacherEvaluationResult(
      {required this.evaluationData, required this.questionResult});
  static TeacherEvaluationResult fromJson(String body) {
    dynamic e = jsonDecode(body) as dynamic;
    dynamic data2 = (e['data2'] as dynamic);
    return TeacherEvaluationResult(
        evaluationData: TeacherEvaluationData(
            averageCount: data2['average'],
            excellentCount: data2['excellent'],
            goodCount: data2['good'],
            poorCount: data2['poor']),
        questionResult: (e['data'] as List<dynamic>)
            .map((e) => QuestionResult(
                  question: e['question'],
                  percentage: e['percentage'],
                ))
            .toList());
  }
}

class QuestionResult {
  final String question;
  final int percentage;
  QuestionResult({
    required this.question,
    required this.percentage,
  });
}

class TeacherEvaluationData {
  final int excellentCount;
  final int goodCount;
  final int averageCount;
  final int poorCount;
  TeacherEvaluationData(
      {required this.averageCount,
      required this.excellentCount,
      required this.goodCount,
      required this.poorCount});
}
