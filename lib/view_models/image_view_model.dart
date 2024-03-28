
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ImageViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  Future<String> uploadAndGetImageUrl(File file, String filename) async {
    String imageUrl = '';

    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child(filename);

    print(mountainsRef.name);

// Create a reference to 'images/mountains.jpg'
    final mountainImagesRef = storageRef.child("images/$filename");
    try {
      _notify(true);
      await mountainsRef.putFile(file);
    } on FirebaseException catch (e) {
      debugPrint("ERROR:${e.message}");
    }
//4
    imageUrl = await mountainImagesRef.getDownloadURL();
    _notify(false);
    return imageUrl;
  }
  Future<String> addImageInFireBase(
      {required File file, required String fileName}) async {
    String imageUrl = "";

    final storageRef = FirebaseStorage.instance.ref();

    final imagesRef = storageRef.child(fileName);

    try {
      _notify(true);
      await imagesRef.putFile(file);

      _notify(false);
    } catch (_) {
      _notify(false);

      debugPrint("Error Bo'ldi :(");
    }
    imageUrl = await imagesRef.getDownloadURL();
    _notify(false);

    return imageUrl;
  }

  Future<String> uploadImage({required XFile pickedFile, required String storagePath}) async {
    try {
      //1

      //2
      var ref = FirebaseStorage.instance.ref().child(storagePath);
      //3
      _notify(true);
      File file = File(pickedFile.path);

      var uploadTask = await ref.putFile(file);

      //4
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      _notify(false);
      return downloadUrl;
    } on FirebaseException catch (error) {
      throw Exception();
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
