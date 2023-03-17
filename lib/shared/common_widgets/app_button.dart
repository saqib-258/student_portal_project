import 'package:flutter/material.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.child,
      required this.onTap,
      this.isDisabled = false});
  final Widget child;
  final VoidCallback onTap;
  final bool isDisabled;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: isDisabled ? Colors.transparent : null,
      borderRadius: BorderRadius.circular(4),
      onTap: isDisabled ? null : onTap,
      child: Ink(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(boxShadow: const [
          // BoxShadow(
          //     color: Colors.grey,
          //     blurRadius: 3,
          //     spreadRadius: 1,
          //     offset: Offset(0, 2))
        ], color: primaryColor, borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
