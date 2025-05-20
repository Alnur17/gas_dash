import 'package:flutter/material.dart';
import 'package:get/get.dart';

void kSnackBar({required String message, required Color bgColor}) {
  if (!Get.isSnackbarOpen) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: bgColor,
        message: message,
        maxWidth: 1170,
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(10),
        borderRadius: 5,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}