import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Function() onPress;
  final String title;
  final bool isActive;

  const CustomButton(
      {super.key,
      required this.onPress,
      required this.title,
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Get.theme.primaryColor;
    if (isActive) {
      return ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(33.0),
            ),
          ),
          child: Text(title));
    }
    return OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF565969),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33.0),
          ),
        ),
        child: Text(title));
  }
}
