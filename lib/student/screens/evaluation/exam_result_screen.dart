import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/models/core/evaluation.dart';
import 'package:student_portal/student/providers/evaluation_provider.dart';

class ExamResultScreen extends StatefulWidget {
  const ExamResultScreen({super.key});

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen>
    with AfterLayoutMixin {
  final provider = getIt<EvaluationProvider>();
  getResultList(String session) {
    provider.getMidFinalMarks(session);
  }

  @override
  Future<FutureOr<void>> afterFirstLayout(BuildContext context) async {
    await provider.getMySessions();
    setState(() {});
  }

  String? selectedVal;
  List<DropdownMenuItem> getItems() {
    List<DropdownMenuItem> dList = [];
    dList = provider.sList!
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();

    return dList;
  }

  List<ExamResult> getList(String type) {
    return provider.midFinalMarks!
        .where((element) => element.type == type)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                    hint: const Text("Select session"),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    value: selectedVal,
                    items: getItems(),
                    onChanged: (val) {
                      setState(() {
                        selectedVal = val;
                        getResultList(val);
                      });
                    }),
              ),
            ),
            height20(),
            Text(
              "Exam Result",
              style: header1TextStyle,
            ),
            height5(),
            Consumer<EvaluationProvider>(builder: (context, provider, _) {
              if (provider.midFinalMarks == null) {
                return const SizedBox.shrink();
              }
              return Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectedVal == null
                        ? const Center(
                            child: Text("Select session above"),
                          )
                        : provider.midFinalMarks!.isEmpty
                            ? const Center(
                                child: Text("not yet uploaded"),
                              )
                            : DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    const TabBar(
                                        indicatorColor: primaryColor,
                                        tabs: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Mid",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Final",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        ]),
                                    height20(),
                                    Expanded(
                                      child: TabBarView(children: [
                                        ResultTabView(eList: getList("mid")),
                                        ResultTabView(eList: getList("final")),
                                      ]),
                                    )
                                  ],
                                ),
                              ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ResultTabView extends StatelessWidget {
  const ResultTabView({super.key, required this.eList});
  final List<ExamResult> eList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                "Course",
                style: header2TextStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                "Obt. marks",
                style: header2TextStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                "Total marks",
                style: header2TextStyle.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        height10(),
        Expanded(
          child: ListView.builder(
              itemCount: eList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Text(
                        eList[index].courseName,
                        style: header2TextStyle,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        eList[index].obtainedmarks.toString(),
                        style: header2TextStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        eList[index].totalMarks.toString(),
                        style: header2TextStyle,
                      ),
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }
}
