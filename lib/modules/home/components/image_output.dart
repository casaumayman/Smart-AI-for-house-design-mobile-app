import 'package:change_house_colors/modules/home/home_controller.dart';
import 'package:change_house_colors/modules/home/models/process_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageOutput extends GetView<HomeController> {
  const ImageOutput({super.key});

  Widget _showLoading(bool isLoading) {
    if (isLoading == false) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) => Obx(() {
        var status = controller.currentStatus.value;
        if (status != EProcessStatus.done) {
          String messsage = "";
          bool isLoading = false;
          if (status == EProcessStatus.init) {
            messsage = "Please pick or capture a picture!";
            isLoading = false;
          } else if (status == EProcessStatus.waitingServer) {
            messsage = "Waiting response from server!";
            isLoading = true;
          } else if (status == EProcessStatus.error) {
            isLoading = false;
            messsage = "Something happened!";
          } else {
            messsage = "Waiting for coloring!";
            isLoading = true;
          }
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [_showLoading(isLoading), Text(messsage)],
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2)),
            child: Image.memory(controller.currentOutputImage.value!),
          );
        }
      });
}
