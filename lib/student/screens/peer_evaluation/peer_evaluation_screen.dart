import 'package:flutter/material.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/student/models/core/peer_evaluation_result.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PeerEvaluationScreen extends StatelessWidget {
  const PeerEvaluationScreen({super.key, required this.result});
  final PeerEvaluationResult result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers Rating"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                width10(),
                Text(
                  result.courseName!,
                  style: boldTextStyle,
                ),
                height10(),
                Text(result.courseCode!),
              ],
            ),
          ),
          SizedBox(height: 200, child: CategoryAxisChart(result.totalResult!)),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: result.questionResult!.length,
                itemBuilder: (context, index) {
                  final questionModel = result.questionResult![index];
                  return Column(
                    children: [
                      Text('Q${index + 1}: ${questionModel!.question!.trim()}'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Card(
                          color: secondaryColor,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(12),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: questionModel.result!.length,
                              itemBuilder: (context, jIndex) {
                                String val;
                                if (questionModel
                                        .result![jIndex]!.percentage! >=
                                    80.0) {
                                  val = "Excellent";
                                } else if (questionModel
                                        .result![jIndex]!.percentage! >=
                                    60.0) {
                                  val = "Good";
                                } else if (questionModel
                                        .result![jIndex]!.percentage! >=
                                    20.0) {
                                  val = "Average";
                                } else {
                                  val = "Poor";
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(questionModel
                                          .result![jIndex]!.teacherName!),
                                      Text(val)
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class CategoryAxisChart extends StatelessWidget {
  final List<Result?> data;

  const CategoryAxisChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 100,
        interval: 25,
      ),
      series: <ChartSeries>[
        ColumnSeries<Result?, String>(
          width: data.length == 1 ? 0.3 : 0.5,
          dataSource: data,
          xValueMapper: (Result? r, _) => r!.teacherName,
          yValueMapper: (Result? r, _) => r!.percentage,
        ),
      ],
    );
  }
}
