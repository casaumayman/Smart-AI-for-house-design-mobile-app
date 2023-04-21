import 'package:change_house_colors/modules/home/components/custom_button.dart';
import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignPicker extends GetView<HomeController> {
  const DesignPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() => Expanded(
                child: CustomButton(
              onPress: () {
                controller.changeMode(EDesignMode.exterior);
              },
              title: "exterior".tr,
              isActive: controller.designMode.value == EDesignMode.exterior,
            ))),
        const SizedBox(
          width: 10,
        ),
        Obx(() => Expanded(
                child: CustomButton(
              onPress: () {
                controller.changeMode(EDesignMode.interior);
              },
              title: "interior".tr,
              isActive: controller.designMode.value == EDesignMode.interior,
            ))),
      ],
    );
  }
}
