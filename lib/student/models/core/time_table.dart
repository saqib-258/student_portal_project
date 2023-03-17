import 'dart:convert';

class TimeTable {
  final String day;
  final List<TimeTableDetail> detail;
  TimeTable({required this.day, required this.detail});
  static List<TimeTable> fromJson(String body) {
    List<TimeTable> timeTable = (jsonDecode(body) as List<dynamic>)
        .map((e) => TimeTable(
              day: e['day'] as String,
              detail: (e['detail'] as List<dynamic>)
                  .map((e) => TimeTableDetail(
                        courseName: e['course'] as String,
                        time: e['time'] as String,
                        venue: e['venue'] as String,
                      ))
                  .toList(),
            ))
        .toList();
    return timeTable;
  }
}

class TimeTableDetail {
  final String courseName;
  final String venue;
  final String time;
  TimeTableDetail(
      {required this.courseName, required this.venue, required this.time});
}
