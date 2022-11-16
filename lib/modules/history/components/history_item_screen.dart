import 'package:change_house_colors/modules/history/components/image_scaffold.dart';
import 'package:change_house_colors/modules/history/components/theme_name.dart';
import 'package:change_house_colors/modules/history/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryItemScreen extends StatelessWidget {
  HistoryItemScreen({super.key, required this.index});
  final int index;
  final controller = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    final model = controller.data[index];
    return Column(
      children: [
        Expanded(child: ImageScaffold(path: model.originImage.path)),
        Expanded(
            child: ImageScaffold(
          path: model.processedImage.path,
        )),
        ThemeName(name: model.originImage.theme.name),
      ],
    );
  }
}
