import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxService {
  Future<void> requestMediaPermissions() async {
    final statuses = await [
      Permission.photos,
      Permission.videos,
      Permission.storage,
    ].request();

    final permanentlyDenied =
        statuses.values.any((s) => s == PermissionStatus.permanentlyDenied);

    if (permanentlyDenied) {
      Get.snackbar(
        'Permission Required',
        'Please enable media access in app settings.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        mainButton: const TextButton(
          onPressed: openAppSettings,
          child: Text('Settings', style: TextStyle(color: Colors.white)),
        ),
      );
    }
  }
}
