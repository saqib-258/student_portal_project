import 'package:flutter/material.dart';

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog(
      {super.key,
      required this.title,
      required this.onConfirm,
      this.isReason = false,
      this.controller});
  final String title;
  final bool isReason;
  final VoidCallback onConfirm;

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          isReason
              ? Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    maxLines: 3,
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: "Reason", border: OutlineInputBorder()),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
      actions: [
        TextButton(onPressed: onConfirm, child: const Text("Yes")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"))
      ],
    );
  }
}
