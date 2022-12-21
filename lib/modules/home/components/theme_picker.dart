import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:change_house_colors/modules/home/models/process_status.dart';
import 'package:change_house_colors/shared/services/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemePicker extends GetView<HomeController> {
  final _themeServices = Get.find<ThemeService>();

  ThemePicker({super.key});

  @override
  Widget build(BuildContext context) {
    onChange(String? value) {
      if (value != null) {
        controller.setTheme(value);
      }
    }

    final themes = _themeServices.themes.map((theme) {
      return DropdownMenuItem<String>(
          value: theme.name, child: Text(theme.name));
    }).toList();

    return Obx(() {
      var status = controller.currentStatus.value;
      bool isDisabled =
          status != EProcessStatus.init && status != EProcessStatus.done;
      return DropdownButton(
          items: themes,
          isExpanded: true,
          value: _themeServices.selectedTheme.name,
          onChanged: isDisabled ? null : onChange);
    });
  }
}
