import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market/data/model/market/notif_model.dart';
import 'package:market/screens/edit/add.dart';
import 'package:market/screens/notification/notification_screen.dart';
import 'package:market/screens/permissions/permission_screen.dart';
import 'package:market/utils/colors/app_colors.dart';
import 'package:market/utils/styles/app_text_style.dart';
import 'package:market/view_models/notification_view_model.dart';
import 'package:market/view_models/product_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../data/model/market/product_model.dart';
import '../../../services/local_notification_services.dart';

Future<void> onBackgroundFCM(RemoteMessage message) async {
  debugPrint("BACKGROUND MODEDA PUSH NOTIFICATION KELDI:${message.notification!.title}");
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int id = 1;

  _init() async {
    // FirebaseMessaging.instance.subscribeToTopic("news");
    // FirebaseMessaging.instance.subscribeToTopic("news");
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM TOKEN ${fcmToken}");
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      debugPrint("Push notification keldiku☺ => ${remoteMessage.notification!.title}");
      if (remoteMessage.notification != null) {
        LocalNotificationService().showNotification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
            id: id);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddScreen()));
              },
              icon: const Icon(Icons.add)),
          // IconButton(
          //     onPressed: () {
          //       FirebaseMessaging.instance.subscribeToTopic("news");
          //     },
          //     icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const NotificationScreen()));
              },
              icon: const Icon(Icons.notifications_on)),
          IconButton(
              onPressed: () {
                LocalNotificationService.localNotificationService.showNotification(
                  title: "Qo'shildi",
                  body: "Maxsulot qo'shildi.",
                  id: id,
                );
                context
                    .read<NotificationViewModel>()
                    .addMessage(messageModel: NotificationModel(name: "${ProductModel}", id: id));
                id++;
              },
              icon: const Icon(Icons.notifications_outlined)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const PermissionScreen()));
              },
              icon: const Icon(Icons.perm_device_info)),
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsViewModel>().listenProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<ProductModel> list = snapshot.data as List<ProductModel>;
            return ListView(
              children: [
                ...List.generate(
                  list.length,
                  (index) {
                    ProductModel product = list[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          list[index].imageUrl,
                        ),
                        title: Text(
                          product.productName,
                          style: AppTextStyle.interRegular
                              .copyWith(color: Colors.black, fontSize: 14.sp),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<ProductsViewModel>()
                                      .deleteProduct(product.docId, context);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<ProductsViewModel>()
                                      .deleteProduct(product.docId, context);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
