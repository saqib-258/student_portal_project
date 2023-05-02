import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/providers/student_financial_assistance_requests_provider.dart';
import 'package:student_portal/admin/screens/financial_assistance/assistance_request_detail_screen.dart';
import 'package:student_portal/shared/common_widgets/app_filter_button.dart';
import 'package:student_portal/shared/common_widgets/student_detail_card.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';

class StudentFinancialAssistanceRequestScreen extends StatefulWidget {
  const StudentFinancialAssistanceRequestScreen({super.key});

  @override
  State<StudentFinancialAssistanceRequestScreen> createState() =>
      _FinancialAssistanceRequestScreenState();
}

class _FinancialAssistanceRequestScreenState
    extends State<StudentFinancialAssistanceRequestScreen>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final provider = getIt<StudentFinancialAssistanceRequestsProvider>();
    provider.getRequests();
  }

  String _selectedFilter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Financial Assistance"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
            child: SingleChildScrollView(
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
                    val: "null",
                    onTap: () {
                      _selectedFilter = "null";
                      setState(() {});
                    },
                  ),
                  AppFilterButton(
                    text: "Accepted",
                    selected: _selectedFilter,
                    val: "true",
                    onTap: () {
                      _selectedFilter = "true";
                      setState(() {});
                    },
                  ),
                  AppFilterButton(
                    text: "Rejected",
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
          ),
          Expanded(
            child: Consumer<StudentFinancialAssistanceRequestsProvider>(
                builder: (context, provider, _) {
              if (provider.sList == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final filteredList = provider.sList!
                  .where((student) =>
                      student.status.toString().contains(_selectedFilter))
                  .toList();
              if (filteredList.isEmpty) {
                return const Center(
                  child: Text("No data found"),
                );
              }
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final model = filteredList[index];
                    return StudentDetailCard(
                      model: model,
                      trailing: Text(
                        model.status == null
                            ? "Pending"
                            : model.status!
                                ? "Accepted"
                                : "Rejected",
                        style: boldTextStyle.copyWith(
                            color: model.status == null
                                ? Colors.red
                                : primaryColor),
                      ),
                      onTap: () async {
                        await navigate(context,
                            AssistanceRequestDetailScreen(model: model));
                        setState(() {});
                      },
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
