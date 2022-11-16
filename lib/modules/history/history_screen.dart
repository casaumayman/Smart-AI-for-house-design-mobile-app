import 'package:card_swiper/card_swiper.dart';
import 'package:change_house_colors/modules/history/components/history_item_screen.dart';
import 'package:change_house_colors/modules/history/components/index_info.dart';
import 'package:change_house_colors/modules/history/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("History"),
          actions: [
            const IndexInfo(),
            IconButton(
                onPressed: controller.onDeleteItem,
                icon: const Icon(
                  Icons.delete,
                  color: Color(0xFFFF7F7F),
                ))
          ],
        ),
        body: Obx(() => Swiper(
              itemCount: controller.total,
              itemBuilder: (context, index) => HistoryItemScreen(index: index),
              scrollDirection: Axis.horizontal,
              loop: false,
              index: controller.currentIndex.value,
              onIndexChanged: controller.onChangeIndex,
            )));
  }
}
