import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_portal/admin/models/services/manage_teacher_evaluation_api.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewTeacherEvaluation extends StatefulWidget {
  NewTeacherEvaluation({super.key});

  @override
  State<NewTeacherEvaluation> createState() => _NewTeacherEvaluationState();
}

class _NewTeacherEvaluationState extends State<NewTeacherEvaluation> {
  String? startDate;

  String? endDate;
  @override
  void initState() {
    startDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
    endDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.now().add(const Duration(days: 3)))
        .toString();
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate =
          DateFormat('dd-MM-yyyy').format(args.value.startDate).toString();
      endDate = DateFormat('dd-MM-yyyy').format(args.value.endDate).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start Evaluation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Select date range",
                style: mediumTextStyle.copyWith(fontWeight: FontWeight.bold)),
            height20(),
            SfDateRangePicker(
              minDate: DateTime.now(),
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.extendableRange,
              initialSelectedRange: PickerDateRange(
                  DateTime.now(), DateTime.now().add(const Duration(days: 3))),
            ),
            height30(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppButton(
                  onTap: () async {
                    final api = ManageTeacherEvaluationApi();
                    api.startTeacherEvaluation(startDate!, endDate!);
                    showToast("Started successfully");
                  },
                  child: Text(
                    "Start Evalution",
                    style: textColorStyle,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
