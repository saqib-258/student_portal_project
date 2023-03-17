import 'package:flutter/material.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';

class AppTextField extends StatefulWidget {
  AppTextField(this.label,
      {super.key, this.controller, required this.icon, this.isObscure});
  final String label;
  bool? isObscure;
  final IconData icon;
  final TextEditingController? controller;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isObscure == null ? false : widget.isObscure!,
          cursorColor: primaryColor,
          decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon,
                size: 20,
              ),
              border: InputBorder.none,
              hintText: widget.label,
              suffixIcon: widget.isObscure == null
                  ? null
                  : InkResponse(
                      radius: 20,
                      onTap: () {
                        setState(() {
                          widget.isObscure = !widget.isObscure!;
                        });
                      },
                      child: Icon(widget.isObscure!
                          ? Icons.visibility
                          : Icons.visibility_off))),
        ),
      ),
    );
  }
}
