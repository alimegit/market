import 'package:flutter/material.dart';
import 'package:market/data/model/notif_model.dart';
import 'package:market/view_models/notification_view_model.dart';
import 'package:provider/provider.dart';

import '../../services/local_notification_services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Notification ",
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationViewModel>().removeAll();
              LocalNotificationService.localNotificationService.cancelAll();
            },
            icon: const Icon(Icons.cancel,color: Colors.red,),
          ),
        ],
      ),
      body: ListView(
        children: List.generate(
          context.watch<NotificationViewModel>().messages.length,
              (index) {
            NotificationModel notificationModel =
            context.watch<NotificationViewModel>().messages[index];
            return ListTile(
              title: Text(notificationModel.name),
              subtitle: Text(notificationModel.id.toString()),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationService.localNotificationService.cancelNotification(notificationModel.id);
                  context.read<NotificationViewModel>().removeMessage(messageModel: notificationModel);
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
        ),
      ),
    );
  }
}