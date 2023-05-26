import 'dart:convert';

class Noticeboard {
  int id;
  String? title;
  String? description;
  String? author;
  String? date;

  Noticeboard(
      {required this.id,
      required this.title,
      required this.description,
      required this.author,
      required this.date});

  Noticeboard.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        author = json['author'],
        date = json['date'];

  static List<Noticeboard> fromJson(String jsonString) {
    final data = jsonDecode(jsonString);
    return List<Noticeboard>.from(data.map((map) => Noticeboard.fromMap(map)));
  }
}
