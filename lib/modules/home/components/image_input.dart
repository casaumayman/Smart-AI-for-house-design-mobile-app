import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageInput extends GetView<HomeController> {
  const ImageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 2)),
      child: Obx(() => _renderImage(controller.currentInputImage.value)),
    );
  }

  Widget _renderImage(Uint8List? bytes) {
    if (bytes == null) {
      return IconButton(
        icon: const Icon(Icons.add_a_photo),
        iconSize: 50,
        onPressed: () {
          controller.showImageSourcePicker();
        },
      );
    }
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.memory(
            bytes,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: const Icon(Icons.add_a_photo),
            iconSize: 30,
            onPressed: () {
              controller.showImageSourcePicker();
            },
          ),
        )
      ],
    );
  }
}
