import 'package:flutter/material.dart';
import 'package:student_portal/admin/providers/add_notice_board_provider.dart';
import 'package:student_portal/admin/screens/notice_board/select_section_screen.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/shared/utils/common.dart';

class AddNoticeBoardScreen extends StatelessWidget {
  AddNoticeBoardScreen({super.key});
  final provider = getIt<AddNoticeBoardProvider>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Notice Board")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: provider.titleController,
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "Title",
                    border: OutlineInputBorder(),
                    hintText: "Enter Title"),
              ),
              height20(),
              TextFormField(
                controller: provider.descriptionController,
                textAlign: TextAlign.start,
                maxLength: 1000,
                maxLines: 8,
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "Description",
                    border: OutlineInputBorder(),
                    hintText: "Enter Description"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (provider.titleController.text.isEmpty) {
                    showToast("Title must not be empty");
                    return;
                  } else if (provider.descriptionController.text.isEmpty) {
                    showToast("Description must not be empty");
                    return;
                  }
                  navigate(context, const SelectSectionScreen());
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text("Next"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
