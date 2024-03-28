import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/utils/colors/app_colors.dart';

class TextFieldItems extends StatelessWidget {
  const  TextFieldItems({super.key, required this.text, required this.controller,this.isError, this.onTap});
  final String text;
  final TextEditingController controller;
  final bool? isError;
  // final Icons? prefix;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        // prefixIcon: IconButton(onPressed: onTap, icon: prefix),
        border: const OutlineInputBorder(),
        labelText: text,
        labelStyle: TextStyle(color: AppColors.black,fontWeight: FontWeight.w500,fontSize: 15.sp)
      ),
    );
  }
}
