import 'package:change_house_colors/modules/result/result_single.dart';
import 'package:change_house_colors/shared/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 0_1681288343672.png;1_1681288343764.png;2_1681288343868.png
    final List<String> listImageUrl = Get.arguments;
    // 0_1681983532536.png;1_1681983532653.png;2_1681983532756.png
    return Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < listImageUrl.length; i++)
                Column(
                  children: [
                    ResultSingle(listImageUrl[i]),
                    SizedBox(
                      height: i == listImageUrl.length - 1 ? 0 : 10,
                    ),
                  ],
                )
            ],
          ),
        ));
  }
}
