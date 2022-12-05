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
          // Obx(() {
          //   bool isDisable = controller.currentImage.value == null;
          //   final handler = isDisable ? null : controller.sendInfoToServer;
          //   return ElevatedButton(
          //       onPressed: handler, child: const Text("Send"));
          // }),
          // Obx(() {
          //   bool isDisable = controller.allowGoToHistory.isFalse;
          //   final handler = isDisable ? null : controller.gotoHistory;
          //   return ElevatedButton(
          //       onPressed: handler, child: const Text("History"));
          // }),
        ],
      ),
    );
  }
}
