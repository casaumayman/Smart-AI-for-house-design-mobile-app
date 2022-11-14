import 'package:change_house_colors/modules/home/models/theme_style.dart';
import 'package:change_house_colors/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final currentImageUrl = Rx<XFile?>(null);
  //Init royal theme
  final selectedTheme =
      Rx<ThemeStyle>(ThemeStyle.fromName(ThemeStyle.listHouseTheme[0]));

  void setTheme(ThemeStyle style) {
    selectedTheme(style);
  }

  void sendInfoToServer() {
    debugPrint("Send info");
  }

  void showImageSourcePicker() async {
    var res = await showImagePicker<String>(["Camera", "Library"]);
    if (res == null) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    if (res == "Camera") {
      var image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        currentImageUrl(image);
      }
      return;
    }
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      currentImageUrl(image);
    }
  }
}
