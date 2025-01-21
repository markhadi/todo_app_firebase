import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Status { success, error }

class SnackbarHelper {
  void showSnackbar({
    required String title,
    required String message,
    Status status = Status.success,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: status == Status.success
          ? Colors.green.shade600
          : Colors.red.shade600,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16.0),
      borderRadius: 8.0,
      duration: const Duration(seconds: 3),
      icon: Icon(
        status == Status.success ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
