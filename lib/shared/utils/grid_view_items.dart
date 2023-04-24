import 'package:flutter/cupertino.dart';
import 'package:student_portal/admin/screens/course_allocation/add_course_allocation.dart';
import 'package:student_portal/admin/screens/date_sheet/manage_date_sheet_screen.dart';
import 'package:student_portal/admin/screens/fee/student_fee_screen.dart';
import 'package:student_portal/admin/screens/fine/student_fine_screen.dart';
import 'package:student_portal/admin/screens/manage_teacher_evaluation/teacher_evaluation_courses_screen.dart';
import 'package:student_portal/admin/screens/time_table/manage_time_table_screen.dart';
import 'package:student_portal/student/screens/attendance/attendance_screen.dart';
import 'package:student_portal/student/screens/evaluation/evaluation_screen.dart';
import 'package:student_portal/student/screens/finance/finance_screen.dart';
import 'package:student_portal/shared/utils/images.dart';
import 'package:student_portal/student/screens/timetable/timetable_screen.dart';

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
      title: "Teacher Evaluation",
      image: assessmentImage,
      screen: const TeacherEvaluationCoursesScreen()),
  GridItem(
      title: "Add Course Allocation",
      image: courseAllocationImage,
      screen: AddCourseAllocation()),
  GridItem(
      title: "Student Fee",
      image: financeImage,
      screen: const StudentFeeScreen()),
  GridItem(title: "Fine", image: fineImage, screen: const StudentFineScreen())
];

class AttendanceGridItem {
  final String title;
  final int absents;
  final int presents;
  AttendanceGridItem(
      {required this.title, required this.absents, required this.presents});
}
