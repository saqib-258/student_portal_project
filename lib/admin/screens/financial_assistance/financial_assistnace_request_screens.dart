import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/models/core/student_financial_assistance_request.dart';
import 'package:student_portal/admin/providers/student_financial_assistance_requests_provider.dart';
import 'package:student_portal/shared/common_widgets/app_filter_button.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';

class FinancialAssistanceRequestScreen extends StatefulWidget {
  const FinancialAssistanceRequestScreen({super.key});

  @override
  State<FinancialAssistanceRequestScreen> createState() =>
      _FinancialAssistanceRequestScreenState();
}

class _FinancialAssistanceRequestScreenState
    extends State<FinancialAssistanceRequestScreen> with AfterLayoutMixin {
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
          Consumer<StudentFinancialAssistanceRequestsProvider>(
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
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("No data found"),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final model = filteredList[index];
                    return _FianancialAssistanceRequestCard(model: model);
                  }),
            );
          }),
        ],
      ),
    );
  }
}

class _FianancialAssistanceRequestCard extends StatelessWidget {
  const _FianancialAssistanceRequestCard({
    required this.model,
  });

  final StudentFinancialAssistanceRequest model;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name),
                  Text(model.regNo),
                  Text('BS${model.program}-${model.semester}${model.section}')
                ],
              ),
              Text(
                model.status == null
                    ? "Pending"
                    : model.status!
                        ? "Accepted"
                        : "Rejected",
                style: boldTextStyle.copyWith(
                    color: model.status == null ? Colors.red : primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
