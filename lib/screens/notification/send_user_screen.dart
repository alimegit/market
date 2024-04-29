import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/api_provider/api_provider.dart';
import '../../data/model/market/user_model.dart';
import '../../utils/styles/app_text_style.dart';
import '../edit/text_field.dart';
class SendOneUserScreen extends StatefulWidget {
   SendOneUserScreen({super.key, required this.isAll,this.userModel});
  UserModel? userModel;
  final bool isAll;

  @override
  State<SendOneUserScreen> createState() => _SendOneUserScreenState();
}

class _SendOneUserScreenState extends State<SendOneUserScreen> {
  bool error = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send User"),
      ),
      body:  Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 110.h,
                    // ),
                    TextFieldItems(
                      text: "Mavzu",
                      controller: bodyController,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFieldItems(
                      isError: error,
                      text: "Nima haqida",
                      controller: titleController,
                    ),
                    SizedBox(
                      height: 200.h,
                    ),

                  ],
                ),
              ),
            ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                if (bodyController.text.isEmpty &&
                    titleController.text.isEmpty) {
                  error = true;
                  setState(() {});
                } else {
                  ApiProvider.sendNotificationToUsers(
                    topicName: widget.isAll ? "users" : null,
                    fcmToken: widget.userModel?.tokenId,
                    title: titleController.text,
                    body: bodyController.text,
                  );
                }
                Navigator.pop(context);
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
            ),
          )
        ],
      )
    );
  }
}
