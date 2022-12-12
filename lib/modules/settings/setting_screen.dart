import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Setting")),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: const [Text("Coming soon...")]),
        ));
  }
}
