import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog extends GetView<HomeController> {
  const LoadingDialog(this.onCancel, {super.key});

  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularProgressIndicator(
            color: Get.theme.primaryColor,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"processing".tr}...",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() {
                    if (controller.inQueue.value == -1) {
                      return Text("initial_your_request".tr);
                    } else if (controller.inQueue.value == 0) {
                      return Text("processing_your_request".tr);
                    }
                    return Text("your_position_in_the_queue_is".trParams(
                        {"inQueue": controller.inQueue.value.toString()}));
                  }),
                  Obx(() {
                    if (controller.remainTime.value == -1) {
                      return Text("time_remaining".tr);
                    }
                    return Text("time_remaining_dynamic".trParams(
                        {"remain": controller.remainTime.value.toString()}));
                  }),
                ]),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            onCancel();
          },
          child: Text(
            "cancel".tr,
            style: TextStyle(color: Get.theme.primaryColor),
          ),
        ),
      ],
    );
  }
}
