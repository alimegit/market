
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static getStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    debugPrint("STORAGE STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.storage.request();
      debugPrint("STORAGE STATUS AFTER ASK:$status");
    }
  }

  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    debugPrint("CAMERA STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      debugPrint("CAMERA STATUS AFTER ASK:$status");
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    debugPrint("LOCATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
      debugPrint("LOCATION STATUS AFTER ASK:$status");
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static getAccessMediaLocation () async {
    PermissionStatus status = await Permission.accessMediaLocation.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.accessMediaLocation.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static appTrackingTransparency() async {
    PermissionStatus status = await Permission.appTrackingTransparency.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.appTrackingTransparency.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static getAssistant() async {
    PermissionStatus status = await Permission.assistant.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.assistant.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static getBluetoothScan() async {
    PermissionStatus status = await Permission.bluetoothScan.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.bluetoothScan.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }
  static getSensor() async {
    PermissionStatus status = await Permission.sensors.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.sensors.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getSomePermissions() async {
    List<Permission> permissions = [
      Permission.notification,
      Permission.sms,
      Permission.speech,
      Permission.microphone,
      Permission.bluetoothConnect,
      Permission.contacts,
    ];
    Map<Permission, PermissionStatus> somePermissionsResults =
    await permissions.request();

    debugPrint(
        "NOTIFICATION STATUS AFTER ASK:${somePermissionsResults[Permission.notification]}");
    debugPrint(
        "SMS STATUS AFTER ASK:${somePermissionsResults[Permission.sms]}");
    debugPrint(
        " SPEECH AFTER ASK:${somePermissionsResults[Permission.speech]}");
  }
}
