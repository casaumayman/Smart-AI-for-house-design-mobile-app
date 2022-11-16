import 'package:change_house_colors/modules/history/components/image_scaffold.dart';
import 'package:change_house_colors/modules/history/components/theme_name.dart';
import 'package:flutter/material.dart';

class HistoryItemScreen extends StatelessWidget {
  const HistoryItemScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
            child: ImageScaffold(
          path: "https://tienganhikun.com/upload/images/house_ikun.jpg",
          testing: true,
        )),
        Expanded(
            child: ImageScaffold(
          path:
              "https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg",
          testing: true,
        )),
        ThemeName(name: "Hahaha"),
      ],
    );
  }
}
