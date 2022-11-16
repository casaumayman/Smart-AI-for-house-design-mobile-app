import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBarAction extends GetView<HomeController> {
  const HomeAppBarAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      child: Obx(() {
        if (controller.isConnectSocket.isTrue) {
          return const Text(
            "Connected",
            style: TextStyle(color: Color(0xFF90EE90)),
          );
        }
        return const Text(
          "Connecting",
          style: TextStyle(color: Color(0xFFFF7F7F)),
        );
      }),
    );
  }
}
