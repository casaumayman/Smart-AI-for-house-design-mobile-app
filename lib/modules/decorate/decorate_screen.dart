import 'package:change_house_colors/modules/decorate/components/image_input.dart';
import 'package:change_house_colors/modules/decorate/components/num_of_result_picker.dart';
import 'package:change_house_colors/modules/decorate/components/theme_picker.dart';
import 'package:change_house_colors/modules/decorate/decorate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DecorateScreen extends GetView<DecorateController> {
  const DecorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenName = Get.arguments ?? "Exterior";
    return Scaffold(
      appBar: AppBar(title: Text(screenName)),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(child: ImageInput()),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const ThemePicker(),
                const NumOfResultPicker(),
                Obx(() => ElevatedButton(
                    onPressed: controller.imageInput.value != null
                        ? controller.startPredict
                        : null,
                    child: const Text("Start")))
              ],
            ),
          ))
        ],
      )),
    );
  }
}
