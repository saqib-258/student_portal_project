import 'package:flutter/material.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/student/models/core/evaluation.dart';

class MarksCardList extends StatelessWidget {
  const MarksCardList({super.key, required this.evaluaitonList});
  final List<Evaluation> evaluaitonList;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: ListView.builder(
              itemCount: evaluaitonList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                            width: 260,
                            child: Text(evaluaitonList[index].title)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 80,
                          color: primaryColor,
                          child: Center(
                            child: Text(
                              "${evaluaitonList[index].obtainedmarks}/${evaluaitonList[index].totalMarks}",
                              style: const TextStyle(color: textColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    ]);
  }
}
