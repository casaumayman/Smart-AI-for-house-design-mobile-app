import 'package:change_house_colors/modules/home/models/theme_style.dart';
import 'package:change_house_colors/services/socket_service.dart';
import 'package:change_house_colors/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final currentImageUrl = Rx<XFile?>(null);
  final _socketService = Get.find<SocketService>();
  //Init royal theme
  final selectedTheme =
      Rx<ThemeStyle>(ThemeStyle.fromName(ThemeStyle.listHouseTheme[0]));

  void setTheme(ThemeStyle style) {
    selectedTheme(style);
  }

  @override
  void onInit() {
    _socketService.connect();
    _socketService.onReceive((data) {
      debugPrint("Received data: $data");
    });
    super.onInit();
  }

  void sendInfoToServer() {
    _socketService.emit("Test emit data!");
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

  void gotoHistory() {
    _socketService.emit("Emit data 2");
  }
}
