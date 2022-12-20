import 'package:change_house_colors/modules/settings/components/theme_setting_item.dart';
import 'package:change_house_colors/shared/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final _themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Setting")),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(() {
            var listSetting = _themeService.themes
                .map(
                  (t) => ThemeSettingItem(model: t),
                )
                .toList();
            return Column(children: listSetting);
          }),
        ));
  }
}
