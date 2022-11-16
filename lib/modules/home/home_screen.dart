import 'package:change_house_colors/modules/home/components/app_bar_action.dart';
import 'package:change_house_colors/modules/home/components/image.dart';
import 'package:change_house_colors/modules/home/components/input_zone.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: const [HomeAppBarAction()],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [
              Expanded(child: DisplayImage()),
              Expanded(child: InputZone()),
            ],
          )),
    );
  }
}
