import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/utils/colors/app_colors.dart';
import 'package:market/utils/permission_utils/app_permissions.dart';
import 'package:market/utils/styles/app_text_style.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Permissons"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getStoragePermission();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Storage",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getCameraPermission();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Camera",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getSomePermissions();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Some",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getLocationPermission();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Location",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getContactsPermission();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Contacts",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getAccessMediaLocation();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Access media",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.appTrackingTransparency();

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "appTrackingTransparency",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getAssistant();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "getAssistant",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getBluetoothScan();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "getBluetoothScan",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: (){
                  AppPermissions.getSensor();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "getSensor",
                        style: AppTextStyle.interRegular
                            .copyWith(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
