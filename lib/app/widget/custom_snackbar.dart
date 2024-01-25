import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  final String title;
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final Color textColor;
  final SnackPosition snackPosition;

  CustomSnackbar({
    required this.title,
    required this.message,
    required this.duration,
    required this.backgroundColor,
    required this.textColor,
    required this.snackPosition,
  });

  void showSnackbar() {
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
    );
  }
}