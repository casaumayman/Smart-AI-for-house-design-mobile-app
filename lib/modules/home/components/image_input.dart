import 'dart:io';
import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

class ImageInput extends GetView<HomeController> {
  const ImageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.showImageSourcePicker,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        color: const Color(0xFFB4B5B5),
        radius: const Radius.circular(10),
        dashPattern: const [5, 5],
        child: Container(
            alignment: Alignment.center,
            child: Obx(() => _renderImage(controller.imageInput.value))),
      ),
    );
  }

  Widget _renderImage(String? path) {
    if (path == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "lib/assets/icons/upload_image.png",
          ),
          Text(
            "upload".tr,
            style: Get.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          )
        ],
      );
    }
    return Container(
      alignment: Alignment.center,
      child: controller.useAsset.value
          ? Image.asset(path, fit: BoxFit.contain)
          : Image.file(
              File(path),
              fit: BoxFit.contain,
            ),
    );
  }
}
