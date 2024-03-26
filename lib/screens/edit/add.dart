import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/data/model/product_model.dart';
import 'package:market/screens/edit/text_field.dart';
import 'package:market/screens/routes.dart';
import 'package:market/utils/styles/app_text_style.dart';
import 'package:market/view_models/product_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../services/local_notification_services.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController imageController = TextEditingController();
    TextEditingController priceController = TextEditingController();
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
                TextFieldItems(
                  text: "Product Nomi",
                  controller: nameController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldItems(
                  text: "Image Url",
                  controller: imageController,
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
                SizedBox(
                  height: 220.h,
                ),
                InkWell(
                  onTap: () {
                    // if (nameController.text.isEmpty &&
                    //     priceController.text.isEmpty &&
                    //     imageController.text.isEmpty &&
                    //     descriptionController.text.isEmpty) {
                    //   showSnackbar(context: context, message: "Bo'sh maydon");
                    // } else {
                      context.read<ProductsViewModel>().insertProducts(
                          ProductModel(
                              price: double.parse(priceController.text),
                              imageUrl: imageController.text,
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
}
