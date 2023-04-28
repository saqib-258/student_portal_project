import 'dart:convert';

class Fine {
  int id;
  String date;
  int amount;
  String description;
  String? status;
  String? receipt;

  Fine({
    required this.id,
    required this.date,
    required this.amount,
    required this.description,
    required this.status,
    required this.receipt,
  });

  factory Fine.fromMap(Map<String, dynamic> json) {
    return Fine(
      id: json['id'],
      date: json['date'],
      amount: json['amount'],
      description: json['description'],
      status: json['status'],
      receipt: json['receipt'],
    );
  }
  static List<Fine> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<Fine>.from(data.map((fineMap) => Fine.fromMap(fineMap)));
  }
}
