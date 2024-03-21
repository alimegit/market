import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/utils/colors/app_colors.dart';
import 'package:market/utils/styles/app_text_style.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: AppTextStyle.interRegular
            .copyWith(color: AppColors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}
