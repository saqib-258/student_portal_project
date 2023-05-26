import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/student/providers/get_advice_provider.dart';

class AdvisesScreen extends StatefulWidget {
  const AdvisesScreen({super.key});

  @override
  State<AdvisesScreen> createState() => _AdvisesScreenState();
}

class _AdvisesScreenState extends State<AdvisesScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<GetAdviceProvider>().getAdviceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Course Advises")),
      body: Consumer<GetAdviceProvider>(builder: (context, provider, _) {
        if (provider.aList == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.aList!.isEmpty) {
          return const Center(child: Text("No data found"));
        }
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 1,
            itemBuilder: (context, index) => Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.aList![index].teacherName!,
                          style: boldTextStyle,
                        ),
                        height10(),
                        Text(provider.aList![index].advice!)
                      ],
                    ),
                  ),
                ));
      }),
    );
  }
}
