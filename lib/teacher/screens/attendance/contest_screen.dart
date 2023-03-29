import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/teacher/providers/student_attendance_provider.dart';

class ContestScreen extends StatefulWidget {
  const ContestScreen({super.key});

  @override
  State<ContestScreen> createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> with AfterLayoutMixin {
  @override
  Future<FutureOr<void>> afterFirstLayout(BuildContext context) async {
    final provider = getIt<StudentAttendanceProvider>();
    await provider.getContests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contests")),
      body:
          Consumer<StudentAttendanceProvider>(builder: (context, provider, _) {
        if (provider.cList == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: provider.cList!.length,
                itemBuilder: (contest, index) {
                  return Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.cList![index].name),
                                    Text(provider.cList![index].regNo),
                                    Text(provider.cList![index].courseName),
                                    Text(
                                        "BS${provider.cList![index].program}-${provider.cList![index].semester}${provider.cList![index].section}"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      provider.cList![index].date,
                                      style: boldTextStyle,
                                    ),
                                    Text(
                                      getWeekDay(DateTime.parse(
                                          provider.cList![index].date)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Accept")),
                              width10(),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Reject")),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
      }),
    );
  }
}
