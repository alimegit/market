import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market/data/model/product_model.dart';
import 'package:market/screens/edit/text_field.dart';
import 'package:market/screens/routes.dart';
import 'package:market/utils/styles/app_text_style.dart';
import 'package:market/view_models/product_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../services/local_notification_services.dart';
import '../../utils/colors/app_colors.dart';
import '../../view_models/image_view_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final picker = ImagePicker();
  String imageUrl = "";
  String storagePath = "";
  XFile? xFile;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    int id = 1;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Product "),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 110.h,
                ),
                IconButton(
                    onPressed: () {
                      takeAnImage();
                    },
                    icon: Icon(Icons.image)),
                TextFieldItems(
                  text: "Product Nomi",
                  controller: nameController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  controller: imageController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            takeAnImage();
                          },
                          icon: const Icon(Icons.image)),
                      border: const OutlineInputBorder(),
                      labelText: "Image",
                      labelStyle: TextStyle(
                          color: AppColors.black, fontWeight: FontWeight.w500, fontSize: 15.sp)),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldItems(
                  text: "Price",
                  controller: priceController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldItems(
                  text: "Haqida",
                  controller: descriptionController,
                ),
                if (context.watch<ImageViewModel>().getLoader) const CircularProgressIndicator(),
                if (imageUrl.isNotEmpty)
                  Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                  ),
                InkWell(
                  onTap: () {
                    context.read<ProductsViewModel>().insertProducts(
                        ProductModel(
                            storagePath: storagePath,
                            price: double.parse(priceController.text),
                            imageUrl: imageUrl,
                            productName: nameController.text,
                            docId: "",
                            productDescription: descriptionController.text,
                            categoryId: "1"),
                        context);
                    Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
                    LocalNotificationService.localNotificationService.showNotification(
                      title: "Qo'shildi",
                      body: "Maxsulot qo'shildi.",
                      id: id,
                    );
                    id++;
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          "Save",
                          style: AppTextStyle.interRegular.copyWith(
                              color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
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
      storagePath = "files/${image.name}";
      imageUrl = await context.read<ImageViewModel>().addImageInFireBase(
            file: File(image!.path),
            fileName: storagePath,
          );
      setState(() {});

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
      storagePath = "files/${image.name}";
      imageUrl = await context.read<ImageViewModel>().addImageInFireBase(
            file: File(image!.path),
            fileName: storagePath,
          );
      setState(() {});

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              ListTile(
                onTap: () async {
                  await _getImageFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  await _getImageFromCamera();
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
}
