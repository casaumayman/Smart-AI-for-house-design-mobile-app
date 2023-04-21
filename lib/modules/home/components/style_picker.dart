import 'package:change_house_colors/modules/home/components/theme_avatar.dart';
import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StylePicker extends GetView<HomeController> {
  const StylePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      const spacing = 10;
      final childWidth = (constrain.maxWidth - (spacing * 2)) / 3;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < controller.listTheme.length; i++)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ThemeAvatar(
                        theme: controller.listTheme[i],
                        isActive: controller.currentTheme.value ==
                            controller.listTheme[i].id,
                        width: childWidth,
                        onTap: () {
                          controller.currentTheme.value =
                              controller.listTheme[i].id;
                        },
                      ),
                      SizedBox(
                          width: i != controller.listTheme.length - 1
                              ? spacing.toDouble()
                              : 0),
                    ],
                  ),
              ],
            )),
      );
    });
  }
}
