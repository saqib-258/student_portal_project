import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/admin/models/core/program_model.dart';
import 'package:student_portal/admin/models/services/add_notice_board_api.dart';
import 'package:student_portal/admin/providers/add_notice_board_provider.dart';
import 'package:student_portal/shared/common_widgets/app_button.dart';
import 'package:student_portal/shared/common_widgets/app_confirm_dialog.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';

class SelectSectionScreen extends StatefulWidget {
  const SelectSectionScreen({super.key});

  @override
  State<SelectSectionScreen> createState() => _SelectSectionScreenState();
}

class _SelectSectionScreenState extends State<SelectSectionScreen>
    with AfterLayoutMixin {
  @override
  Future<FutureOr<void>> afterFirstLayout(BuildContext context) async {
    await getIt<AddNoticeBoardProvider>().getSectionList();
  }

  _onAddNoticeBoard() {
    final provider = getIt<AddNoticeBoardProvider>();
    Map<String, dynamic> noticeBoardMap;
    List<Map<String, dynamic>> sList = [];
    for (var program in provider.pList!) {
      for (var semester in program.semesters) {
        for (var section in semester.sections) {
          if (section.isSelected) {
            sList.add(
                {"semester": semester, "section": section, "program": program});
          }
        }
      }
    }
    noticeBoardMap = {
      "description": provider.descriptionController.text,
      "title": provider.titleController.text
    };
    Map<String, dynamic> finalMap = {"n": noticeBoardMap, "slist": sList};
    showDialog(
        context: context,
        builder: (context) => AppConfirmDialog(
            title: "Dou you want add Notice board?",
            onConfirm: () async {
              Navigator.pop(context);
              EasyLoading.show(
                indicator: const CircularProgressIndicator(),
                dismissOnTap: false,
                maskType: EasyLoadingMaskType.black,
              );
              var result = await AddNoticeBoardApi.addNoticeBoard(finalMap);
              await Future.delayed(const Duration(seconds: 1));
              result.fold((l) {
                showToast("Something went wrong");
              }, (r) {
                if (r == true) {
                  showToast("Notice board Added Successfully");
                } else {
                  showToast("Something went wrong");
                }
              });

              EasyLoading.dismiss();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notice Board"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "Select Sections",
              style: mediumTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
            height20(),
            Expanded(
              child: Consumer<AddNoticeBoardProvider>(
                  builder: (context, provider, _) {
                if (provider.pList == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: provider.pList!.length,
                  itemBuilder: (context, index) =>
                      CheckboxTree(program: provider.pList![index]),
                );
              }),
            ),
            AppButton(
              onTap: _onAddNoticeBoard,
              child: Text(
                "Add",
                style: textColorStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CheckboxTree extends StatefulWidget {
  final ProgramModel program;
  final Function(SemesterModel, SectionModel)? onSectionTap;

  const CheckboxTree({Key? key, required this.program, this.onSectionTap})
      : super(key: key);

  @override
  _CheckboxTreeState createState() => _CheckboxTreeState();
}

class _CheckboxTreeState extends State<CheckboxTree> {
  late ProgramModel _program;

  @override
  void initState() {
    super.initState();
    _program = widget.program;
  }

  void _onProgramSelected(bool? value) {
    setState(() {
      _program.isSelected = value!;
      for (var semester in _program.semesters) {
        semester.isSelected = value;
        for (var section in semester.sections) {
          section.isSelected = value;
        }
      }
    });
  }

  void _onSemesterSelected(bool? value, SemesterModel semester) {
    setState(() {
      semester.isSelected = value!;
      for (var section in semester.sections) {
        section.isSelected = value;
      }
      _program.isSelected =
          _program.semesters.every((semester) => semester.isSelected);
    });
  }

  void _onSectionSelected(
      bool? value, SectionModel section, SemesterModel semester) {
    setState(() {
      section.isSelected = value!;
      semester.isSelected =
          semester.sections.every((section) => section.isSelected);
      _program.isSelected =
          _program.semesters.every((semester) => semester.isSelected);
    });
  }

  Widget _buildSectionList(SemesterModel semester) {
    return Column(
      children: [
        for (var section in semester.sections)
          CheckboxListTile(
            contentPadding: const EdgeInsets.only(left: 50),
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(section.section,
                style: TextStyle(
                  fontWeight: section.isSelected ? FontWeight.bold : null,
                )),
            value: section.isSelected,
            onChanged: (value) => _onSectionSelected(value, section, semester),
          )
      ],
    );
  }

  Widget _buildSemesterTile(SemesterModel model) {
    return ExpansionTile(
      title: CheckboxListTile(
        title: Text(
          'Semester ${model.semester}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: model.isSelected,
        onChanged: (value) => _onSemesterSelected(value, model),
        controlAffinity: ListTileControlAffinity.leading,
      ),
      children: [
        _buildSectionList(model),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            _program.program,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: _program.isSelected,
          onChanged: _onProgramSelected,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: _program.semesters.length,
            itemBuilder: (context, index) =>
                _buildSemesterTile(_program.semesters[index]))
      ],
    );
  }
}
