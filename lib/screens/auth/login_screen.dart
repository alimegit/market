import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market/screens/auth/type_login.dart';
import 'package:market/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/auth_view_model.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: context.watch<AuthViewModel>().loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h,),
                    Center(
                      child: Image.asset(
                        AppImages.login,
                        width: 225.w,
                        height: 218.h,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      "Login",
                      style: AppTextStyle.interMedium.copyWith(
                          color: AppColors.white, fontSize: 22.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 34.w, right: 34.w),
                      child: TextFormField(
                        style:const  TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const  Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                          fillColor: AppColors.c262626,
                          filled: true,
                          labelText: "EMAIL",
                          labelStyle: AppTextStyle.interMedium.copyWith(
                              color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 34.w, right: 34.w),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                          ),
                          fillColor: AppColors.c262626,
                          filled: true,
                          labelText: "Password",
                          labelStyle: AppTextStyle.interMedium.copyWith(
                              color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30.r),
                      onTap: (){context.read<AuthViewModel>().loginUser(
                        context,
                        email: emailController.text,
                        password: passwordController.text,
                      );},
                      child: Container(
                        width: 203.w,
                        height: 43.h,
                        decoration: BoxDecoration(
                          color: AppColors.c262626,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: AppTextStyle.interSemiBold.copyWith(
                                color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Text(
                      "OR",
                      style: AppTextStyle.interSemiBold
                          .copyWith(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Login with",
                      style: AppTextStyle.interSemiBold
                          .copyWith(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginType(
                          onTap: () {
                            context.read<AuthViewModel>().signInWithGoogle(context,
                                Platform.isAndroid ? null : AppConstants.clientId);
                          },
                          icon: SvgPicture.asset(AppImages.google),
                        ),
                        SizedBox(
                          width: 20.h,
                        ),
                        LoginType(
                          onTap: () {},
                          icon: SvgPicture.asset(AppImages.apple),
                        ),
                        SizedBox(
                          width: 20.h,
                        ),
                        LoginType(
                          onTap: () {},
                          icon: SvgPicture.asset(
                            AppImages.facebook,
                            width: 12.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style: AppTextStyle.interSemiBold.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14.sp),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, RouteNames.registerRoute);
                          },
                          child: Text(
                            "Register Now",
                            style: AppTextStyle.interSemiBold.copyWith(
                                color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            ),
      ),
    );
  }
}
