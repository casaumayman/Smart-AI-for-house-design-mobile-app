import 'dart:async';

import 'package:change_house_colors/routes/routes.dart';
import 'package:change_house_colors/shared/models/model.dart';
import 'package:change_house_colors/shared/services/services.dart';
import 'package:change_house_colors/shared/utils/image_picker_utils.dart';
import 'package:change_house_colors/shared/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DecorateController extends GetxController {
  final _themeServices = Get.find<ThemeService>();
  final _predictServices = Get.find<PredictService>();
  late final List<ThemeModel> listTheme;

  String _fileInputName = "";
  Timer? _timer;

  final imageInput = Rx<String?>(null);
  final currentTheme = 1.obs;
  final numberOfResult = 1.obs;

  @override
  void onInit() {
    listTheme = Get.arguments == "Interior"
        ? _themeServices.getListInteriors()
        : _themeServices.getListExteriors();
    currentTheme.value = listTheme[0].id;
    super.onInit();
  }

  void showImageSourcePicker() async {
    var res = await showImagePicker<String>(["Camera", "Library"]);
    if (res == null) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    try {
      if (res == "Camera") {
        var image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          imageInput.value = image.path;
          _fileInputName = image.name;
        }
        return;
      }
      var image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageInput.value = image.path;
        _fileInputName = image.name;
      }
    } catch (e) {
      showSnackbarError("$e");
    }
  }

  void startPredict() async {
    _showLoadingDialog();
    try {
      final imageUrl =
          await _predictServices.uploadImage(imageInput.value!, _fileInputName);
      debugPrint("Image url: $imageUrl");
      final predictId = await _predictServices.predict(
          imageUrl, currentTheme.value, numberOfResult.value);
      debugPrint("Predict id: $predictId");
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
        debugPrint("Get result");
        try {
          final resultUrls = await _predictServices.getResults(predictId);
          if (resultUrls != null) {
            debugPrint("Result: $resultUrls");
            timer.cancel();
            Get.back();
            Get.toNamed(Routes.results, arguments: resultUrls);
          }
        } catch (e) {
          Get.back();
          timer.cancel();
          debugPrint("Get result error: ${e.toString()}");
          //Get result error
        }
      });
    } catch (e) {
      Get.back();
      showSnackbarError(e.toString());
    }
  }

  void _showLoadingDialog() {
    Get.dialog(
        AlertDialog(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Loading..."),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "It will take longer if many",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text("users are in the queue.",
                      style: TextStyle(fontWeight: FontWeight.w300))
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                if (_timer != null) {
                  if (_timer!.isActive) {
                    _timer!.cancel();
                  }
                  _timer = null;
                }
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
        barrierDismissible: false);
  }
}
