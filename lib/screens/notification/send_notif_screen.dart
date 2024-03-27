import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/data/api_provider/api_provider.dart';
import '../../services/local_notification_services.dart';
import '../../utils/styles/app_text_style.dart';
import '../edit/text_field.dart';
import '../routes.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  int id = 1;
  _init() async {
    // FirebaseMessaging.instance.subscribeToTopic("news");
    // FirebaseMessaging.instance.subscribeToTopic("news");
    String? fcmToken = await  FirebaseMessaging.instance.getToken();
    debugPrint("FCM TOKEN ${fcmToken}");
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      debugPrint("Push notification keldiku☺ => ${remoteMessage.notification!.title}");
      if(remoteMessage.notification!=null ){
        LocalNotificationService().showNotification(title: remoteMessage.notification!.title!, body: remoteMessage.notification!.body!, id: id);
      }
    });
  }
  @override
  void initState() {
    _init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    // SenNotifModel senNotifModel = SenNotifModel(body: bodyController.text, title: titleController.text);

    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldItems(
                    text: "Mavzu",
                    controller: bodyController,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFieldItems(
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
                // if (nameController.text.isEmpty &&
                //     priceController.text.isEmpty &&
                //     imageController.text.isEmpty &&
                //     descriptionController.text.isEmpty) {
                //   showSnackbar(context: context, message: "Bo'sh maydon");
                // } else {
                Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
                LocalNotificationService.localNotificationService.showNotification(
                  title: titleController.text,
                  body: bodyController.text,
                  id: id,
                );
                id++;
                String messageId = await ApiProvider.sendNotificationToUsers(
                    title: titleController.text, body: bodyController.text);
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
      ),
    );
  }
}
