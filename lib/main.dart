import 'package:change_house_colors/constants/theme.dart';
import 'package:change_house_colors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      getPages: Routes.pages,
      initialRoute: "/",
    );
  }
}
