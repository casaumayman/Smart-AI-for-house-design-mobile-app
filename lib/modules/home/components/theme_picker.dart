import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:change_house_colors/modules/home/models/process_status.dart';
import 'package:change_house_colors/modules/home/models/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemePicker extends GetView<HomeController> {
  ThemePicker({super.key});
  final themes = ThemeStyle.listHouseTheme.map((name) {
    var theme = ThemeStyle.fromName(name);
    return DropdownMenuItem<ThemeStyle>(value: theme, child: Text(theme.name));
  }).toList();

  @override
  Widget build(BuildContext context) {
    onChange(value) {
      if (value != null) {
        controller.setTheme(value);
      }
    }

    return Obx(() {
      var status = controller.currentStatus.value;
      bool isDisabled =
          status != EProcessStatus.init && status != EProcessStatus.done;
      return DropdownButton(
          items: themes,
          isExpanded: true,
          value: controller.selectedTheme.value,
          onChanged: isDisabled ? null : onChange);
    });
  }
}
