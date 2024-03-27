import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/screens/notification/send_user_screen.dart';
import 'package:market/screens/tabs/profile/buttons.dart';
import 'package:market/utils/colors/app_colors.dart';
import 'package:market/utils/styles/app_text_style.dart';
import 'package:provider/provider.dart';
import '../../../utils/images/app_images.dart';
import '../../../view_models/auth_view_model.dart';
import '../../notification/send_notif_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Account",
          style: AppTextStyle.interRegular.copyWith(color: Colors.black, fontSize: 18.sp),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthViewModel>().logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const  SendNotificationScreen()));
            },
            icon: const Icon(
              Icons.send,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>   SendOneUserScreen(isAll: true)));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: user != null
          ? context.watch<AuthViewModel>().loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 63,
                              child: Image.asset(
                                AppImages.splash,
                                width: 105,
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.displayName.toString().toUpperCase(),
                                  style: TextStyle(color: AppColors.black, fontSize: 18.sp),
                                ),
                                Text(
                                  user.uid.toString(),
                                  style: TextStyle(color: Colors.blue, fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                           SizedBox(height: 16.h,),
                        Buttons(text: "ACCOUNT", onTap: (){}),
                        SizedBox(height: 12.h,),
                        Buttons(text: "Center", onTap: (){}),
                        SizedBox(height: 12.h,),
                        Buttons(text: "Settings", onTap: (){}),
                        SizedBox(height: 12.h,),
                        Buttons(text: "Help", onTap: (){}),
                        SizedBox(height: 12.h,),
                      ],
                    ),
                  ),
                )
          : const Center(
              child: Text("USER NOT EXIST"),
            ),
    );
  }
}
