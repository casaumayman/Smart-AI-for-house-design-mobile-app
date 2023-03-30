import 'package:change_house_colors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
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
                onPressed: () {
                  Get.toNamed(Routes.decorate, arguments: "Exterior");
                },
                child: const Text("Exterior")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.decorate, arguments: "Interior");
                },
                child: const Text("Interior"))
          ],
        ),
      ),
    );
  }
}
