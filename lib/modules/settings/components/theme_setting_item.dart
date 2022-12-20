import 'package:change_house_colors/modules/settings/components/house_element.dart';
import 'package:change_house_colors/modules/settings/setting_controller.dart';
import 'package:change_house_colors/shared/services/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSettingItem extends GetView<SettingController> {
  const ThemeSettingItem({super.key, required this.model});
  final ThemeModel model;

  @override
  Widget build(BuildContext context) {
    final List<HouseElement> listElement = [
      HouseElement(
        elementName: "Roof",
        color: model.roofColor,
        onTap: () => controller.showColorModel(
            model.roofColor, model.name, EHouseElementType.roof),
      ),
      HouseElement(
        elementName: "Wall",
        color: model.wallColor,
        onTap: () => controller.showColorModel(
            model.wallColor, model.name, EHouseElementType.wall),
      ),
      HouseElement(
        elementName: "Door",
        color: model.doorColor,
        onTap: () => controller.showColorModel(
            model.doorColor, model.name, EHouseElementType.door),
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
              enabled: false,
              controller: TextEditingController(text: model.name),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: "Theme name",
              )),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: listElement,
            ),
          ),
        ],
      ),
    );
  }
}
