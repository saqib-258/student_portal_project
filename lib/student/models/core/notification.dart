class NotificationModel {
  String title;
  String description;
  DateTime dateTime;
  String author;
  bool isSeen;

  NotificationModel(
      {required this.title,
      required this.description,
      required this.author,
      required this.dateTime,
      this.isSeen = false});

  static List<NotificationModel> notificationList = [
    NotificationModel(
      title: "",
      description:
          '''BIIT Sports Society is going to organise different indoor and outdoor activities for sports week going to held in week 14. You can register yourself for the following events:
- Cricket
- Footbal
- Badminton 
- Table tennis 
- Chess 
- Ludo

Feel free to  contact Mr. Usama for more details +92 334 5775059''',
      author: "Admin",
      dateTime: DateTime.now().subtract(
        const Duration(days: 3),
      ),
    ),
    NotificationModel(
        title: "",
        description: '''
Dear students 

Cyber Security Society is conducting a seminar on 
"Training and practicing cyber security made available. 
Experience in researching and building a cyber range-NCR" 

Presenter: Dr. Muhammad Mudassar Yamin
Dated: Monday Jan 2, 2022
Venue : lab 2
Timing : 4:30 to 5:30 PM
 
Make sure your availability in time
              ''',
        author: "Admin",
        dateTime: DateTime.now().subtract(const Duration(days: 6)))
  ];
}
