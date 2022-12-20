import 'package:change_house_colors/shared/services/services.dart';
import 'package:change_house_colors/shared/services/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final _themeService = Get.find<ThemeService>();

  void showColorModel(
      Color currentColor, String themeName, EHouseElementType type) async {
    var newColor = await Get.defaultDialog<Color>(
        title: "Color picker",
        content: BlockPicker(
            pickerColor: currentColor,
            onColorChanged: ((valueColor) {
              Get.back(result: valueColor);
            })));
    if (newColor == null) {
      return;
    }
    _themeService.updateTheme(themeName, type, newColor);
  }
}
