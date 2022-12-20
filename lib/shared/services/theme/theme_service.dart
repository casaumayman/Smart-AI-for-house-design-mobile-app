import 'package:change_house_colors/constants/localstorage_constants.dart';
import 'package:change_house_colors/shared/services/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  late final SharedPreferences _localStore;
  final themes = [
    ThemeModel(name: "Royal"),
    ThemeModel(
        name: "Ocean",
        roofColor: const Color.fromRGBO(90, 207, 23, 1),
        wallColor: const Color.fromRGBO(206, 219, 15, 1),
        doorColor: const Color.fromRGBO(219, 66, 15, 1))
  ].obs;

  final _selectedThemeName = "Royal".obs;

  ThemeModel get selectedTheme {
    return themes.firstWhereOrNull(
        (element) => element.name == _selectedThemeName.value)!;
  }

  @override
  void onInit() async {
    _localStore = await SharedPreferences.getInstance();
    var jsonStringList = _localStore.getStringList(settingKey);
    if (jsonStringList == null) {
      return;
    }
    debugPrint("Load list theme from localstore!");
    var listTheme =
        jsonStringList.map((jsonTheme) => ThemeModel.fromJsonString(jsonTheme));
    themes.assignAll(listTheme);
    super.onInit();
  }

  void setTheme(String name) {
    var exist = themes.firstWhereOrNull((element) => element.name == name);
    if (exist != null) {
      _selectedThemeName.value = name;
    }
  }

  void updateTheme(String themeName, EHouseElementType type, Color value) {
    var themeIndex = themes.indexWhere((t) => t.name == themeName);
    if (themeIndex == -1) {
      return;
    }
    var theme = themes[themeIndex];
    switch (type) {
      case EHouseElementType.roof:
        theme.roofColor = value;
        break;
      case EHouseElementType.wall:
        theme.wallColor = value;
        break;
      case EHouseElementType.door:
        theme.doorColor = value;
        break;
    }
    themes.setRange(themeIndex, themeIndex + 1, [theme]);
    _updateLocalValue();
  }

  void _updateLocalValue() {
    var strList = themes.map((theme) => theme.toJsonString()).toList();
    _localStore.setStringList(settingKey, strList);
  }
}
