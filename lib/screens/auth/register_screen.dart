import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/screens/auth/widget_register.dart';
import 'package:market/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_models/auth_view_model.dart';
import '../routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: context.watch<AuthViewModel>().loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(34.w, 27.h, 34.w, 0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.register),
                    SizedBox(
                      height: 29.h,
                    ),
                    Text(
                      "Sign Up",
                      style: AppTextStyle.interSemiBold.copyWith(
                          color: AppColors.white, fontSize: 22.5.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    RegisterTextField(
                      controller: nameController,
                      labelText: 'First Name',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    RegisterTextField(
                      controller: usernameController,
                      labelText: 'username',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    RegisterTextField(
                      controller: emailController,
                      labelText: 'Email',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    RegisterTextField(
                      controller: passwordController,
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30.r),
                      onTap: () {
                        context.read<AuthViewModel>().registerUser(
                              context,
                              email: emailController.text,
                              password: passwordController.text,
                              username: usernameController.text,
                            );
                      },
                      child: Container(
                        width: 203.w,
                        height: 49.h,
                        decoration: BoxDecoration(
                            color: Colors.blue, borderRadius: BorderRadius.circular(30.r)),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: AppTextStyle.interSemiBold.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22.sp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: AppTextStyle.interRegular.copyWith(
                              color: AppColors.white, fontWeight: FontWeight.w400, fontSize: 14.sp),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, RouteNames.loginRoute);
                          },
                          child: Text(
                            "Login",
                            style: AppTextStyle.interRegular.copyWith(
                                color: AppColors.c1A72DD, fontWeight: FontWeight.w400, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
            
                  ],
                ),
              ),
          ),
    );
  }
}
