import 'package:change_house_colors/modules/result/result_single.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  const ResultCard(this.listImage, {super.key});
  final List<String> listImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: listImage.map((url) => ResultSingle(url)).toList(),
    );
  }
}
