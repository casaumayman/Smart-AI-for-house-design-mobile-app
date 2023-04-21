import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbarError(String message) {
  const mainColor = Colors.red;
  Get.snackbar("error".tr, message,
      colorText: mainColor,
      borderColor: mainColor,
      borderWidth: 1,
      backgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 200),
      icon: const Icon(
        Icons.error_outline_outlined,
        color: mainColor,
      ));
}

void showSnackbarSuccess(String message) {
  const mainColor = Colors.green;
  Get.snackbar("success".tr, message,
      colorText: mainColor,
      borderColor: mainColor,
      borderWidth: 1,
      backgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 200),
      icon: const Icon(
        Icons.check,
        color: mainColor,
      ));
}

void showSnackbarInfo(String message) {
  const mainColor = Colors.blue;
  Get.snackbar("notification".tr, message,
      colorText: mainColor,
      borderColor: mainColor,
      borderWidth: 1,
      backgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 200),
      icon: const Icon(
        Icons.info_outline,
        color: mainColor,
      ));
}
