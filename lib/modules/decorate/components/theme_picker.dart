import 'package:change_house_colors/modules/decorate/decorate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemePicker extends GetView<DecorateController> {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context) {
    onChange(int? value) {
      if (value == null) {
        return;
      }
      controller.currentTheme.value = value;
    }

    final themes = controller.listTheme.map((theme) {
      return DropdownMenuItem<int>(value: theme.id, child: Text(theme.name));
    }).toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Theme/Style:",
            style: TextStyle(fontSize: 16),
          ),
          Obx(() => DropdownButton(
              items: themes,
              value: controller.currentTheme.value,
              isExpanded: true,
              onChanged: onChange))
        ],
      ),
    );
  }
}
