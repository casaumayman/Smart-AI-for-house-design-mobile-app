import 'package:change_house_colors/modules/settings/components/house_element.dart';
import 'package:flutter/material.dart';

class ThemeSettingItem extends StatelessWidget {
  const ThemeSettingItem(
      {super.key,
      required this.name,
      this.wallColor = const Color.fromRGBO(0, 255, 0, 1),
      this.doorColor = const Color.fromRGBO(0, 0, 255, 1),
      this.roofColor = const Color.fromRGBO(255, 0, 0, 1)});
  final String name;
  final Color wallColor;
  final Color doorColor;
  final Color roofColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const TextField(
              decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: "Theme name",
          )),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                HouseElement(elementName: "Roof"),
                HouseElement(elementName: "Wall"),
                HouseElement(elementName: "Door"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
