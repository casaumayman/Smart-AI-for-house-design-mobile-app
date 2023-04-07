import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Features")),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: controller.onPressExterior,
                child: const Text("Exterior")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: controller.onPressInterior,
                child: const Text("Interior"))
          ],
        ),
      ),
    );
  }
}
