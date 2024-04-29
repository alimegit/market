import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:market/screens/auth/register_screen.dart';
import 'package:market/screens/auth/type_login.dart';
import 'package:market/screens/chat_app/screens/home_screen/home_screen.dart';
import 'package:market/utils/images/app_images.dart';

import '../../BLOC/auth_state.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthErrorState) {
            return Center(
              child: Text(state.errorText),
            );
          }
          if (state is AuthInitialState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Image.asset(AppImages.login, width: 240.w),
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
                      style: const TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
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
                  Padding(
                    padding: EdgeInsets.only(left: 34.w, right: 34.w, top: 20.h),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
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
                    height: 13.h,
                  ),
                  Text(
                    "OR",
                    style: AppTextStyle.interSemiBold.copyWith(
                        color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Login with",
                    style: AppTextStyle.interSemiBold.copyWith(
                        color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginType(
                        onTap: () {
                          context.read<AuthBloc>().add(AuthGoogleEvent(context));
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
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(30.r),
                    onTap: () {
                      if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                        context.read<AuthBloc>().add(
                              AuthLoginEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      } else {
                        _showSnackBar();
                      }
                    },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (BuildContext context, AuthState state) {
          if (state is AuthSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HelloScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  _showSnackBar({String title = "Empty input"}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
        ),
      ),
    );
  }
}
