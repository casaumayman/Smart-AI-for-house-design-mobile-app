import 'package:change_house_colors/modules/home/components/image_input.dart';
import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageInputPicker extends GetView<HomeController> {
  const ImageInputPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AspectRatio(
          aspectRatio: 338 / 109,
          child: ImageInput(),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                child: Divider(
                  color: Color(0xFFC9C9C9),
                  height: 1,
                  thickness: 1,
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "or".tr,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF565969)),
                  )),
              const Expanded(
                child: Divider(
                  color: Color(0xFFC9C9C9),
                  height: 1,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
        Text(
          "select_a_sample".tr,
          style: Get.theme.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 150,
              child: AspectRatio(
                aspectRatio: 113 / 74,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Obx(() {
                      final mode = controller.designMode.value;
                      final sampleAssets = mode == EDesignMode.exterior
                          ? HomeController.exteriorAssets
                          : HomeController.interiorAssets;
                      return InkWell(
                        onTap: () {
                          controller.onPickAsset(sampleAssets[0]);
                        },
                        child: Image.asset(
                          sampleAssets[0],
                          fit: BoxFit.cover,
                        ),
                      );
                    })),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 150,
              child: AspectRatio(
                aspectRatio: 113 / 74,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Obx(() {
                      final mode = controller.designMode.value;
                      final sampleAssets = mode == EDesignMode.exterior
                          ? HomeController.exteriorAssets
                          : HomeController.interiorAssets;
                      return InkWell(
                        onTap: () {
                          controller.onPickAsset(sampleAssets[1]);
                        },
                        child: Image.asset(
                          sampleAssets[1],
                          fit: BoxFit.cover,
                        ),
                      );
                    })),
              ),
            )
          ],
        )
      ],
    );
  }
}
