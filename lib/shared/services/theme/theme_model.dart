import 'dart:convert';

import 'package:change_house_colors/shared/utils/color_utils.dart';
import 'package:flutter/material.dart';

class ThemeModel {
  ThemeModel(
      {required this.name,
      this.wallColor = const Color.fromRGBO(0, 255, 0, 1),
      this.doorColor = const Color.fromRGBO(0, 0, 255, 1),
      this.roofColor = const Color.fromRGBO(255, 0, 0, 1)});
  String name;
  Color wallColor;
  Color doorColor;
  Color roofColor;

  String toJsonString() {
    Map<String, dynamic> mapJson = {
      "name": name,
      "roofColor": roofColor.toString(),
      "wallColor": wallColor.toString(),
      "doorColor": doorColor.toString(),
    };
    return jsonEncode(mapJson);
  }

  factory ThemeModel.fromJsonString(String jsonStr) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    String roofString = jsonMap["roofColor"];
    String wallString = jsonMap["wallColor"];
    String doorString = jsonMap["doorColor"];
    return ThemeModel(
        name: jsonMap["name"],
        doorColor: stringToColor(doorString),
        roofColor: stringToColor(roofString),
        wallColor: stringToColor(wallString));
  }
}

enum EHouseElementType { roof, wall, door }
