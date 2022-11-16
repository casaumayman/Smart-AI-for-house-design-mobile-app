import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeName extends StatelessWidget {
  const ThemeName({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(name,
          style: TextStyle(
              fontSize: 25,
              color: Get.theme.colorScheme.primary,
              fontWeight: FontWeight.bold)),
    );
  }
}
