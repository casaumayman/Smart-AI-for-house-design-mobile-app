import 'dart:io';

import 'package:change_house_colors/constants/network_constants.dart';
import 'package:change_house_colors/shared/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ResultSingle extends StatelessWidget {
  const ResultSingle(this.imageUrl, {super.key});
  final String imageUrl;

  _onDownload() async {
    _showLoadingDialog();
    final directory = Directory('/sdcard/Download/SmartHouseDesign');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    final filePath = '${directory.path}/result_$timestamp.png';
    final response =
        await http.get(Uri.parse("$networkHost/public/result/$imageUrl"));
    final file = File(filePath);
    final future = file.writeAsBytes(response.bodyBytes);
    future.then((value) {
      Get.back();
      showSnackbarSuccess("Image saved to ${value.path}");
    }).catchError((onError) {
      Get.back();
      showSnackbarError("Save image failed!");
      debugPrint("Save image fail $onError");
    });
  }

  _showLoadingDialog() {
    Get.dialog(AlertDialog(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 20),
          Text("Saving image..."),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          "$networkHost/public/result/$imageUrl",
          fit: BoxFit.contain,
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Row(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     debugPrint("Zoom clicked");
              //   },
              //   child: Align(
              //       alignment: Alignment.bottomRight,
              //       child: Container(
              //         padding: const EdgeInsets.all(5),
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(100),
              //             border: Border.all(width: 2, color: Colors.white)),
              //         child: const Icon(
              //           Icons.zoom_out_map,
              //           color: Colors.white,
              //           size: 30,
              //         ),
              //       )),
              // ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  _onDownload();
                },
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: const Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
