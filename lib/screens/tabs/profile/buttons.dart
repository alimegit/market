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
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: AppTextStyle.interRegular
              .copyWith(color: AppColors.black, fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
