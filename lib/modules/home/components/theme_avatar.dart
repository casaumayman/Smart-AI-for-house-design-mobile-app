import 'package:change_house_colors/constants/network_constants.dart';
import 'package:change_house_colors/shared/models/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeAvatar extends StatelessWidget {
  final ThemeModel theme;
  final bool isActive;
  final double width;
  final Function() onTap;

  const ThemeAvatar(
      {super.key,
      required this.theme,
      this.isActive = false,
      required this.width,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isActive
                  ? Border.all(
                      color: Get.theme.primaryColor,
                      width: 2,
                    )
                  : null,
            ),
            child: theme.descriptImg == null
                ? const CircleAvatar(
                    backgroundImage: AssetImage(
                        'lib/assets/icons/empty_image.png'), // set the image path
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(
                        '$networkHost/public/theme/${theme.descriptImg}'), // set the image path
                  ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: width),
            child: Text(
              theme.name,
              style: isActive ? TextStyle(color: Get.theme.primaryColor) : null,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
