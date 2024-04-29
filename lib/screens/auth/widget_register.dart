import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';

class RegisterTextField extends StatelessWidget {
  const RegisterTextField(
      {super.key, required this.controller, required this.labelText, required this.prefixIcon});

  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon.icon,
          color: Colors.blue,
        ),
        fillColor: AppColors.c262626,
        filled: true,
        labelText: labelText,
        labelStyle: AppTextStyle.interMedium
            .copyWith(color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
