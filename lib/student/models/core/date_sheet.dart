import 'dart:convert';

class DateSheet {
  String type;
  List<DateSheetDetail> detail;
  DateSheet({required this.type, required this.detail});
  static DateSheet fromJson(String body) {
    dynamic result = (jsonDecode(body) as dynamic);
    DateSheet dateSheet = DateSheet(
        type: result['type'],
        detail: (result['dateSheet'] as List<dynamic>)
            .map((e) => DateSheetDetail(
                courseName: e['courseName'],
                day: e['day'],
                date: e['date'],
                time: e['time']))
            .toList());
    return dateSheet;
  }
}

class DateSheetDetail {
  String date;
  String time;
  String day;
  String courseName;
  DateSheetDetail(
      {required this.courseName,
      required this.day,
      required this.date,
      required this.time});
}
