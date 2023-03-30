import 'package:card_swiper/card_swiper.dart';
import 'package:change_house_colors/modules/result/result_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> listImageUrl = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: Container(
        alignment: Alignment.center,
        child: Swiper(
          loop: false,
          itemBuilder: (BuildContext context, int index) {
            debugPrint("Swipe index: $index");
            if (index == 0) {
              return ResultCard(
                  listImageUrl.sublist(0, listImageUrl.length == 1 ? 1 : 2));
            }
            return ResultCard(listImageUrl.sublist(2, listImageUrl.length));
          },
          itemCount: ((listImageUrl.length - 1) ~/ 2) + 1,
          pagination: const SwiperPagination(),
          control: const SwiperControl(),
        ),
      ),
    );
  }
}
