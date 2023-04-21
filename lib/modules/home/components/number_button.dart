import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberButton extends StatelessWidget {
  const NumberButton(
      {super.key,
      this.isActive = false,
      required this.num,
      required this.onTap});

  final bool isActive;
  final int num;
  final Function() onTap;

  @override
  Widget build(context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isActive
              ? null
              : Border.all(
                  color: const Color(0xFFC9C9C9),
                  style: BorderStyle.solid,
                  width: 1)),
      child: isActive
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFF5EF),
                shape: const CircleBorder(),
                elevation: 0,
              ),
              child: Text(
                num.toString(),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Get.theme.primaryColor,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
                side: BorderSide.none,
              ),
              child: Text(
                num.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF565969),
                ),
              ),
            ),
    );
  }
}
