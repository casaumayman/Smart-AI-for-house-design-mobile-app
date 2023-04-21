import 'package:change_house_colors/constants/theme.dart';
import 'package:change_house_colors/constants/translation.dart';
import 'package:change_house_colors/routes/app_bindings.dart';
import 'package:change_house_colors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeftWithFade,
      title: 'Smart AI for house design',
      theme: appTheme,
      translations: MyTranslations(),
      locale: const Locale('vi', 'VN'),
      getPages: Routes.pages,
      initialRoute: "/",
      initialBinding: AppBindings(),
    );
  }
}
