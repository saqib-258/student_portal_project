import 'dart:async';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/providers/student_fine_provider.dart';
import 'package:student_portal/shared/common_widgets/student_detail_card.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

class StudentFineScreen extends StatefulWidget {
  const StudentFineScreen({super.key});

  @override
  State<StudentFineScreen> createState() => _StudentFineScreenState();
}

class _StudentFineScreenState extends State<StudentFineScreen>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<StudentFineProvider>().getFineList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fine"),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16), shape: const StadiumBorder()),
        onPressed: () {},
        child: const Text("Add Fine"),
      ),
      body: Consumer<StudentFineProvider>(builder: (context, provider, _) {
        if (provider.fList == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (provider.fList!.isEmpty) {
          return const Center(
            child: Text("No fine added yet"),
          );
        }
        return ListView.builder(
            padding:
                const EdgeInsets.only(top: 8, bottom: 75, left: 8, right: 8),
            itemCount: provider.fList!.length,
            itemBuilder: (context, index) {
              final model = provider.fList![index];
              return StudentDetailCard(
                  model: model,
                  trailing: Text(
                    model.status == null && model.receipt != null
                        ? "Paid"
                        : model.status == null
                            ? "Pending"
                            : model.status!
                                ? "Approved"
                                : "Rejected",
                    style: TextStyle(
                        color:
                            model.status == null ? Colors.red : primaryColor),
                  ),
                  onTap: () {});
            });
      }),
    );
  }
}
