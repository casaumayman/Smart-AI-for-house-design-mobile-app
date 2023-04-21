import 'package:change_house_colors/modules/home/components/number_button.dart';
import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberOfResultPicker extends GetView<HomeController> {
  const NumberOfResultPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 1; i <= 3; i++)
                Row(
                  children: [
                    NumberButton(
                      num: i,
                      onTap: () {
                        controller.numberOfResult.value = i;
                      },
                      isActive: controller.numberOfResult.value == i,
                    ),
                    SizedBox(
                      width: i == 3 ? 0 : 10,
                    ),
                  ],
                ),
            ],
          );
        }),
        const SizedBox(
          height: 5,
        ),
        Text(
          "note".tr,
          style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        )
      ],
    );
  }
}
