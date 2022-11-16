import 'package:change_house_colors/modules/history/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexInfo extends GetView<HistoryController> {
  const IndexInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 10),
      child: Obx(() {
        final index = controller.currentIndex.value + 1;
        final total = controller.total;
        return Text(
          "$index/$total",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        );
      }),
    );
  }
}
