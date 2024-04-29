import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../data/model/market/user_model.dart';
import '../utils/constants/app_constants.dart';

class UserViewModel extends ChangeNotifier {
  List<UserModel> users = [];
  bool _loading = false;

  bool get loading => _loading;

  Future<void> getUsers() async {
    _notification(true);
    try {
      FirebaseFirestore.instance
          .collection(AppConstants.userTable)
          .get()
          .then((value) {
        // value.docs.map((e) {
        //   debugPrint(e.toString());
        // });
        users = value.docs.map((e) => UserModel.fromJson(e.data())).toList();
      });
      _notification(false);
    } on FirebaseException catch (_) {
      _notification(false);
    } catch (_) {
      _notification(false);
    }
  }

  _notification(bool v) {
    _loading = v;
    notifyListeners();
  }
}