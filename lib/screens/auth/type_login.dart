import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market/utils/colors/app_colors.dart';
class LoginType extends StatelessWidget {
  const LoginType({super.key, required this.icon, required this.onTap});
  final SvgPicture icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          color: AppColors.c262626,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: icon,widthFactor: 2.w,
          ),
        ),
      ),
    );
  }
}
