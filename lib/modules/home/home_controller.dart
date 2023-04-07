import 'dart:io';

import 'package:change_house_colors/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  _writeFiles(List<String> files, String directory) async {
    for (final String assetImage in files) {
      final String imageName = assetImage.split('/').last;
      final String imagePath = '$directory/$imageName';

      // check if the image already exists in the folder
      if (await File(imagePath).exists()) {
        continue;
      }
      // read the asset image as bytes
      final ByteData bytes = await rootBundle.load(assetImage);
      final Uint8List imageData = bytes.buffer.asUint8List();
      // write the image bytes to the file
      await File(imagePath).writeAsBytes(imageData);
    }
  }

  prepareSamples(String type) async {
    Get.dialog(
        AlertDialog(
          content: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Loading..."),
              ]),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
        barrierDismissible: false);
    const String directory = 'sdcard/Download';
    const String folderPath = '$directory/images';
    await Directory(folderPath).create(recursive: true);
    if (type == "Interior") {
      final List<String> assetImages = [
        'lib/assets/samples/interior-sample-1.jpg',
        'lib/assets/samples/interior-sample-2.jpg',
      ];
      await _writeFiles(assetImages, folderPath);
    } else {
      final List<String> assetImages = [
        'lib/assets/samples/exterior-sample-1.jpg',
        'lib/assets/samples/exterior-sample-2.jpg',
      ];
      await _writeFiles(assetImages, folderPath);
    }
    Get.back();
  }

  onPressInterior() async {
    await prepareSamples("Interior");
    Get.toNamed(Routes.decorate, arguments: "Interior");
  }

  onPressExterior() async {
    await prepareSamples("Exterior");
    Get.toNamed(Routes.decorate, arguments: "Exterior");
  }
}
