import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/providers/peer_evaluation_result_provider.dart';
import 'package:student_portal/student/screens/peer_evaluation/peer_evaluation_screen.dart';

class PeerEvaluationCourseScreen extends StatefulWidget {
  const PeerEvaluationCourseScreen({super.key});

  @override
  State<PeerEvaluationCourseScreen> createState() =>
      _PeerEvaluationTeachersScreenState();
}

class _PeerEvaluationTeachersScreenState
    extends State<PeerEvaluationCourseScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<PeerEvaluationResultProvider>().getPeerEvaluationResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers Courses"),
      ),
      body: Consumer<PeerEvaluationResultProvider>(
          builder: (context, provider, _) {
        if (provider.rList == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.rList!.isEmpty) {
          return const Center(child: Text("No data found"));
        }
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: provider.rList!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  navigate(context,
                      PeerEvaluationScreen(result: provider.rList![index]));
                },
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(provider.rList![index].courseName!),
                        Text(
                          provider.rList![index].courseCode!,
                          style: header2TextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
