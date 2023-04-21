import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends GetView<HomeController> {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              "language_setting".tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            selected: Get.locale == const Locale('vi', 'VN'),
            selectedTileColor: const Color(0xFFFFF5EF),
            selectedColor: Get.theme.primaryColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: Image.asset("lib/assets/icons/vietnamese.png"),
            title: const Text('Tiếng Việt'),
            onTap: () {
              // Get.updateLocale(Locale('vi', 'VN'));
              controller.changeLanguage(const Locale('vi', 'VN'));
              Get.back();
            },
          ),
          ListTile(
            selected: Get.locale == const Locale('en', 'US'),
            selectedTileColor: const Color(0xFFFFF5EF),
            selectedColor: Get.theme.primaryColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: Image.asset("lib/assets/icons/english.png"),
            title: const Text('English'),
            onTap: () {
              // Get.updateLocale(Locale('vi', 'VN'));
              controller.changeLanguage(const Locale('en', 'US'));
              Get.back();
            },
          ),
          ListTile(
            selected: Get.locale == const Locale('ja', 'JP'),
            selectedTileColor: const Color(0xFFFFF5EF),
            selectedColor: Get.theme.primaryColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: Image.asset("lib/assets/icons/japanese.png"),
            title: const Text('日本語'),
            onTap: () {
              // Get.updateLocale(Locale('vi', 'VN'));
              controller.changeLanguage(const Locale('ja', 'JP'));
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
