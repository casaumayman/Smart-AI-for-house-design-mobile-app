import 'package:flutter/material.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting(
      {super.key,
      required this.name,
      this.wallColor = const Color.fromRGBO(0, 255, 0, 1),
      this.doorColor = const Color.fromRGBO(0, 0, 255, 1),
      this.roofColor = const Color.fromRGBO(255, 0, 0, 1)});
  final String name;
  final Color wallColor;
  final Color doorColor;
  final Color roofColor;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
