import 'package:change_house_colors/modules/decorate/decorate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumOfResultPicker extends GetView<DecorateController> {
  const NumOfResultPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Number of result:",
            style: TextStyle(fontSize: 16),
          ),
          Obx(() => Slider.adaptive(
                value: controller.numberOfResult.value.toDouble(),
                onChanged: (v) {
                  controller.numberOfResult.value = v.toInt();
                },
                min: 1,
                max: 4,
                label: controller.numberOfResult.value.toString(),
                divisions: 3,
              )),
          const Text(
            "Note: The larger the number of result, the slower the processing speed!",
            style: TextStyle(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
