import 'package:flutter/material.dart';

const _primaryColor = 0xFFFC7735;

final appTheme = ThemeData(
  primaryColor: const Color(_primaryColor),
  textTheme: const TextTheme(
      bodyMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF565969))),
);
