import 'package:change_house_colors/shared/services/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  final List<ThemeModel> themes = const [
    ThemeModel(name: "Royal"),
    ThemeModel(
        name: "Ocean",
        roofColor: Color.fromRGBO(90, 207, 23, 1),
        wallColor: Color.fromRGBO(206, 219, 15, 1),
        doorColor: Color.fromRGBO(219, 66, 15, 1))
  ];

  final _selectedThemeName = "Royal".obs;

  ThemeModel get selectedTheme {
    return themes.firstWhereOrNull(
        (element) => element.name == _selectedThemeName.value)!;
  }

  void setTheme(String name) {
    var exist = themes.firstWhereOrNull((element) => element.name == name);
    if (exist != null) {
      _selectedThemeName.value = name;
    }
  }
}
