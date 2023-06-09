import 'package:flutter/cupertino.dart';
import 'package:student_portal/admin/screens/course_advisor/add_course_advisor.dart';
import 'package:student_portal/admin/screens/course_allocation/add_course_allocation.dart';
import 'package:student_portal/admin/screens/date_sheet/manage_date_sheet_screen.dart';
import 'package:student_portal/admin/screens/fee/student_fee_screen.dart';
import 'package:student_portal/admin/screens/fine/student_fine_screen.dart';
import 'package:student_portal/admin/screens/manage_teacher_evaluation/teacher_evaluation_courses_screen.dart';
import 'package:student_portal/admin/screens/notice_board/add_notice_board_screen.dart';
import 'package:student_portal/admin/screens/peer_evaluation/add_peer_evaluation_screen.dart';
import 'package:student_portal/admin/screens/time_table/manage_time_table_screen.dart';
import 'package:student_portal/student/screens/attendance/attendance_screen.dart';
import 'package:student_portal/student/screens/evaluation/evaluation_screen.dart';
import 'package:student_portal/student/screens/finance/fee/fee_screen.dart';
import 'package:student_portal/student/screens/finance/finance_screen.dart';
import 'package:student_portal/shared/utils/images.dart';
import 'package:student_portal/student/screens/timetable/timetable_screen.dart';
import 'package:student_portal/teacher/screens/course_advisor/course_advisor.dart';
import 'package:student_portal/teacher/screens/manage_course/manage_course_screen.dart';
import 'package:student_portal/teacher/screens/peer_evaluation/peer_evaluation_courses.dart';

class GridItem {
  final String image;
  final String title;
  final Widget screen;
  GridItem({required this.title, required this.image, required this.screen});
}

List<GridItem> studentDashboarGridItems = [
  GridItem(
      title: "Attendance",
      image: attendanceImage,
      screen: const AttendanceScreen()),
  GridItem(
      title: "Grading",
      image: evaluationImage,
      screen: const EvaluationScreen()),
  GridItem(
      title: "Timetable",
      image: timetableImage,
      screen: const TimetableScreen()),
  GridItem(title: "Finance", image: financeImage, screen: const FinanceScreen())
];
List<GridItem> parentDashboarGridItems = [
  GridItem(
      title: "Attendance",
      image: attendanceImage,
      screen: const AttendanceScreen()),
  GridItem(
      title: "Grading",
      image: evaluationImage,
      screen: const EvaluationScreen()),
  GridItem(
      title: "Timetable",
      image: timetableImage,
      screen: const TimetableScreen()),
  GridItem(title: "Fee", image: financeImage, screen: const FeeScreen())
];
List<GridItem> adminDashboardGridItems = [
  GridItem(
      title: "Manage Timetable",
      image: timetableImage,
      screen: ManageTimeTableScreen()),
  GridItem(
      title: "Manage Datesheet",
      image: datesheetImage,
      screen: const ManageDateSheetScreen()),
  GridItem(
      title: "Student Fee",
      image: financeImage,
      screen: const StudentFeeScreen()),
  GridItem(title: "Fine", image: fineImage, screen: const StudentFineScreen()),
  GridItem(
      title: "Teacher Evaluation",
      image: assessmentImage,
      screen: const TeacherEvaluationCoursesScreen()),
  GridItem(
      title: "Notice Board",
      image: noticeBoardImage,
      screen: AddNoticeBoardScreen()),
  GridItem(
      title: "Add Course Allocation",
      image: courseAllocationImage,
      screen: AddCourseAllocation()),
  GridItem(
      title: "Add Course Advisor",
      image: courseAdvisorImage,
      screen: AddCourseAdvisor()),
  GridItem(
      title: "Peer Evaluation",
      image: peerEvaluationImage,
      screen: AddPeerEvaluationScreen()),
];
List<GridItem> teacherDashboardGridItems = [
  GridItem(
      title: "Manage Courses",
      image: manageCourseImage,
      screen: const ManageCourseScreen()),
  GridItem(
      title: "Course Advisor",
      image: courseAdvisorImage,
      screen: const CourseAdvisor()),
  GridItem(
      title: "Teacher Evaluation",
      image: peerEvaluationImage,
      screen: const PeerEvaluationCourses()),
];

class AttendanceGridItem {
  final String title;
  final int absents;
  final int presents;
  AttendanceGridItem(
      {required this.title, required this.absents, required this.presents});
}
