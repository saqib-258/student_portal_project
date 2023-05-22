import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/providers/student_fee_provider.dart';
import 'package:student_portal/admin/screens/fee/student_fee_status_screen.dart';
import 'package:student_portal/shared/common_widgets/app_filter_button.dart';
import 'package:student_portal/shared/common_widgets/student_detail_card.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';

class StudentFeeScreen extends StatefulWidget {
  const StudentFeeScreen({super.key});

  @override
  State<StudentFeeScreen> createState() => _StudentFeeScreenState();
}

class _StudentFeeScreenState extends State<StudentFeeScreen>
    with AfterLayoutMixin {
  String _searchText = '';
  String _selectedFilter = "";

  @override
  Future<FutureOr<void>> afterFirstLayout(BuildContext context) async {
    final provider = getIt<StudentFeeProvider>();
    await provider.getFeeStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Fee")),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AppFilterButton(
                  text: "All",
                  selected: _selectedFilter,
                  val: "",
                  onTap: () {
                    _selectedFilter = "";
                    setState(() {});
                  },
                ),
                AppFilterButton(
                  text: "Pending",
                  selected: _selectedFilter,
                  val: "true",
                  onTap: () {
                    _selectedFilter = "true";
                    setState(() {});
                  },
                ),
                AppFilterButton(
                  text: "Approved",
                  selected: _selectedFilter,
                  val: "false",
                  onTap: () {
                    _selectedFilter = "false";
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<StudentFeeProvider>(
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

                filteredList = filteredList
                    .where((student) =>
                        student.isPending.toString().contains(_selectedFilter))
                    .toList();
                if (filteredList.isEmpty) {
                  return const Center(
                    child: Text("No data found"),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    return await provider.getFeeStudents();
                  },
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final model = filteredList[index];
                        return StudentDetailCard(
                            model: model,
                            trailing: Text(
                              model.isPending ? "Pending" : "Approved",
                              style: boldTextStyle.copyWith(
                                  color: model.isPending
                                      ? Colors.red
                                      : primaryColor),
                            ),
                            onTap: () async {
                              navigate(context,
                                  StudentFeeStatusScreen(regNo: model.regNo));
                            });
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
