import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/models/core/date_sheet.dart';
import 'package:student_portal/student/providers/date_sheet_provider.dart';

class DatesheetScreen extends StatefulWidget {
  const DatesheetScreen({super.key});

  @override
  State<DatesheetScreen> createState() => _DatesheetScreenState();
}

class _DatesheetScreenState extends State<DatesheetScreen>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final provider = getIt<DateSheetProvider>();
    await provider.getDateSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Datesheet"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Consumer<DateSheetProvider>(builder: (context, provider, _) {
            if (provider.dateSheet == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.dateSheet!.type == "empty") {
              return const Center(child: Text("Datesheet not uploaded yet"));
            } else {
              List<DateSheetDetail> dList = provider.dateSheet!.detail;
              dList.sort((a, b) => DateTime.parse(convertDateFormat(a.date))
                  .compareTo(DateTime.parse(convertDateFormat(b.date))));
              return Column(
                children: [
                  if (provider.dateSheet!.type == "mid")
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Mid-Term Datesheet",
                        style: header1TextStyle,
                      ),
                    ),
                  if (provider.dateSheet!.type == "final")
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Final-Term Datesheet",
                        style: header1TextStyle,
                      ),
                    ),
                  height10(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Course",
                              style: boldTextStyle,
                            )),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Date",
                              style: boldTextStyle,
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Time",
                              style: boldTextStyle,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: dList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Text(dList[index].courseName)),
                                  width10(),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dList[index].date,
                                          style: header3TextStyle,
                                        ),
                                        Text(getWeekDay(DateTime.parse(
                                                convertDateFormat(
                                                    dList[index].date)))
                                            .substring(0, 3))
                                      ],
                                    ),
                                  ),
                                  width10(),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      dList[index].time,
                                      style: header3TextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
        ));
  }
}
