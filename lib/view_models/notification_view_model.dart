import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../data/model/notif_model.dart';


class NotificationViewModel extends ChangeNotifier {
  List<NotificationModel> messages = [];

  addMessage({required NotificationModel messageModel}) {

    messages.add(messageModel);
    debugPrint("${messages.length}");

    notifyListeners();
  }

  removeMessage({required NotificationModel messageModel}) {
    messages.remove(messageModel);
    notifyListeners();
  }

  removeAll() {
    messages = [];
    notifyListeners();
  }
  newerSend(){
     FirebaseMessaging.instance.unsubscribeFromTopic("news");
     debugPrint("Kelmaydikuu");
     notifyListeners();
  }
}