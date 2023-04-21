import 'dart:io';

import 'package:change_house_colors/constants/localstorage_constants.dart';
import 'package:change_house_colors/routes/routes.dart';
import 'package:change_house_colors/shared/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SplashController extends GetxController {
  final themeService = Get.find<ThemeService>();

  @override
  void onInit() async {
    super.onInit();
    try {
      await initLocale();
      await themeService.loadListTheme();
      Get.offNamed(Routes.home);
    } catch (e) {
      Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: const Text('Server is offline, please come back later!'),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => exit(0),
          ),
        ],
      ));
    }
  }

  initLocale() async {
    final preferences = await SharedPreferences.getInstance();
    final settingLocaleStr = preferences.getString(localeKey);
    if (settingLocaleStr != null) {
      debugPrint("Setting locale: $settingLocaleStr");
      Locale settingLocale = Locale.fromSubtags(
          languageCode:
              Intl.canonicalizedLocale(settingLocaleStr).split('_')[0],
          countryCode:
              Intl.canonicalizedLocale(settingLocaleStr).split('_')[1]);
      await Get.updateLocale(settingLocale);
      return;
    }
    final deviceLocale = Get.deviceLocale;
    debugPrint("Device locale: $deviceLocale");
    if (deviceLocale == null) {
      await Get.updateLocale(const Locale('en', 'US'));
      return;
    }
    const vnLocale = Locale('vi', 'VN');
    const jpLocale = Locale('ja', 'JP');
    const enLocale = Locale('en', 'US');
    if (deviceLocale == vnLocale) {
      await Get.updateLocale(vnLocale);
      return;
    } else if (deviceLocale == jpLocale) {
      await Get.updateLocale(jpLocale);
      return;
    }
    await Get.updateLocale(enLocale);
  }
}
