import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:market/services/local_notification_services.dart';
import '../data/model/product_model.dart';
import '../utils/constants/app_constants.dart';
import '../utils/utility_functions.dart';

class ProductsViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<ProductModel> categoryProduct = [];

  Stream<List<ProductModel>> listenProducts() => FirebaseFirestore.instance
      .collection(AppConstants.products)
      .snapshots()
      .map(
        (event) =>
        event.docs.map((doc) => ProductModel.fromJson(doc.data())).toList(),
  );

  Future<void> getProductsByCategory(String categoryDocId) async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection(AppConstants.products)
        .where("category_id", isEqualTo: categoryDocId)
        .get()
        .then((snapshot) {
      categoryProduct =
          snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    });
    _notify(false);
  }

  insertProducts(ProductModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(cf.id)
          .update({"doc_id": cf.id});
      LocalNotificationService().showNotification(title: "${productModel.productName}", body:"Qo'shildi" , id: 1);


      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  updateProduct(ProductModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(productModel.docId)
          .update(productModel.toJsonForUpdate());

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  deleteProduct(String docId, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.products)
          .doc(docId)
          .delete();

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}