import 'dart:convert';

class TeacherEvaluationQuestion {
  final int id;
  final String question;
  int? answer;
  static Map<int, dynamic> answers = {
    4: "Excellent",
    3: "Good",
    2: "Average",
    0: "Poor"
  };

  TeacherEvaluationQuestion({required this.question, required this.id});
  static List<TeacherEvaluationQuestion> fromJson(String body) {
    List<TeacherEvaluationQuestion> qList = [];
    qList = (jsonDecode(body) as List<dynamic>)
        .map((e) =>
            TeacherEvaluationQuestion(question: e['question'], id: e['id']))
        .toList();
    return qList;
  }
}
