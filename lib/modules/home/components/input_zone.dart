import 'package:change_house_colors/modules/home/components/theme_picker.dart';
import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputZone extends GetView<HomeController> {
  const InputZone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          ThemePicker(),
          ElevatedButton(
              onPressed: () {
                controller.sendInfoToServer();
              },
              child: const Text("Send")),
          ElevatedButton(onPressed: () {}, child: const Text("History")),
        ],
      ),
    );
  }
}
