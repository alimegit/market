import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/utils/colors/app_colors.dart';
import 'package:market/utils/styles/app_text_style.dart';

import '../../utils/images/app_images.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.c0001FC,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 140.h,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Latech",
                  style: AppTextStyle.interBold
                      .copyWith(color: Colors.white, fontSize: 44.sp, fontWeight: FontWeight.w800),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "T e  c  h  m  a  r  k  e  t ",
                style: AppTextStyle.interBold
                    .copyWith(color: Colors.white, fontSize: 21.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 39.h,
              ),
              Image.asset(AppImages.splash),
              SizedBox(height: 50.h,),
              InkWell(
                onTap: (){
                  _init();
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Let's Start",
                        style: AppTextStyle.interMedium.copyWith(
                            color: Colors.blueAccent, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
