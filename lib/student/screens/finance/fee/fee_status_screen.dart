import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';
import 'package:student_portal/student/providers/fee_provider.dart';
import 'package:student_portal/student/screens/finance/fee/fee_status_detail_screen.dart';

class FeeStatus extends StatefulWidget {
  const FeeStatus({super.key});

  @override
  State<FeeStatus> createState() => _FeeStatusState();
}

class _FeeStatusState extends State<FeeStatus> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final provider = getIt<FeeProvider>();
    provider.getFeeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fee Status"),
      ),
      body: Consumer<FeeProvider>(builder: (context, provider, _) {
        if (provider.cList == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: provider.cList!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  navigate(context,
                      FeeStatusDetailScreen(model: provider.cList![index]));
                },
                child: Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                          'Installment No ${provider.cList![index].installmentNo}'),
                      subtitle: Text('${provider.cList![index].amount} RS'),
                      trailing: Text(
                        provider.cList![index].status ? "Done" : "Pending",
                        style: boldTextStyle.copyWith(
                            color: provider.cList![index].status
                                ? primaryColor
                                : Colors.red),
                      ),
                    )),
              );
            });
      }),
    );
  }
}
