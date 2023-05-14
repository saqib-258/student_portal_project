import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/providers/get_students_provider.dart';
import 'package:student_portal/admin/screens/fine/add_fine_screen.dart';
import 'package:student_portal/shared/common_widgets/student_detail_card.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';

class SelectStudentFineScreen extends StatefulWidget {
  const SelectStudentFineScreen({super.key});

  @override
  State<SelectStudentFineScreen> createState() =>
      _SelectStudentFineScreenState();
}

class _SelectStudentFineScreenState extends State<SelectStudentFineScreen>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    getIt<GetStudentsProvider>().getStudents();
  }

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Student")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              padding: const EdgeInsets.all(16),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: Consumer<GetStudentsProvider>(
              builder: (context, provider, _) {
                if (provider.sList == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var filteredList = provider.sList!
                    .where((student) =>
                        student.name
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()) ||
                        student.regNo
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()) ||
                        ('BS${student.program}-${student.semester}${student.section}')
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))
                    .toList();
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return StudentDetailCard(
                          model: filteredList[index],
                          trailing: TextButton(
                            onPressed: () {
                              navigateAndRepalce(context,
                                  AddFineScreen(model: filteredList[index]));
                            },
                            child: const Text("select"),
                          ));
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
