import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/models/core/evaluation.dart';
import 'package:student_portal/student/providers/evaluation_provider.dart';
import 'package:student_portal/student/screens/evaluation/marks_card_list.dart';

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({super.key});

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen>
    with AfterLayoutMixin {
  final provider = getIt<EvaluationProvider>();
  List<Evaluation> getList(String type) {
    return provider
        .assignmentQuizMarks![
            context.watch<SelectedCourseProvider>().selectedCourse]
        .detail
        .where((element) => element.type == type)
        .toList();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    provider.getAssignmentQuizMarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("Grading")),
      body: Consumer<EvaluationProvider>(builder: (context, provider, _) {
        if (provider.assignmentQuizMarks == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: double.infinity,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.assignmentQuizMarks!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<SelectedCourseProvider>()
                                .changeCourse(index);
                          },
                          child: Card(
                            shape: const StadiumBorder(),
                            color: index ==
                                    context
                                        .watch<SelectedCourseProvider>()
                                        .selectedCourse
                                ? primaryColor
                                : null,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                    child: Text(
                                  provider
                                      .assignmentQuizMarks![index].courseName,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: index ==
                                              context
                                                  .watch<
                                                      SelectedCourseProvider>()
                                                  .selectedCourse
                                          ? textColor
                                          : null),
                                ))),
                          ),
                        );
                      }),
                )),
            Expanded(
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TabBar(indicatorColor: primaryColor, tabs: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Assignment",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Quiz",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ]),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          MarksCardList(evaluaitonList: getList("assignment")),
                          MarksCardList(evaluaitonList: getList("quiz"))
                        ]),
                      )
                    ],
                  )),
            ),
          ],
        );
      }),
    );
  }
}

class SelectedCourseProvider with ChangeNotifier {
  int selectedCourse = 0;
  void changeCourse(int ind) {
    selectedCourse = ind;
    notifyListeners();
  }
}
