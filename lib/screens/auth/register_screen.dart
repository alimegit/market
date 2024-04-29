

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/screens/auth/widget_register.dart';
import 'package:market/screens/chat_app/screens/home_screen/home_screen.dart';

import '../../BLOC/auth_state.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../view_models/image_view_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
String imageUrl = "";
class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final picker = ImagePicker();
  String storagePath = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                  SizedBox(height:50.h ,),
                  Text(
                    "REGISTER",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 50.h,),
                  RegisterTextField(
                    controller: nameController,
                    labelText: 'First Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  RegisterTextField(
                    labelText: 'username',
                    prefixIcon: const Icon(Icons.person), controller: nameController,
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
                 IconButton(onPressed: (){
                   takeAnImage();
                 }, icon: Icon(Icons.image)),
                  SizedBox(height: 60.h,),
                  InkWell(
                    child: const Center(
                      child: Text("Login"),
                    ),
                    onTap: () {
                      if (nameController.text.isEmpty &&
                          emailController.text.isEmpty &&
                          passwordController.text.isEmpty) {
                        _showSnackBar();
                      } else {
                        context.read<AuthBloc>().add(
                          AuthRegisterEvent(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text, imageUrl: imageUrl,
                          ),
                        );
                      }
                    },
                  ),
                SizedBox(height: 50.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
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

  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      var imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
       imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              ListTile(
                onTap: () async {
                  _getImageFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  _getImageFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kameradan olish"),
              ),
              SizedBox(height: 24.h),
            ],
          );
        });
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