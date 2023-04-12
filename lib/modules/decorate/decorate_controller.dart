import 'dart:async';

import 'package:change_house_colors/modules/decorate/components/loading_dialog.dart';
import 'package:change_house_colors/modules/decorate/components/samples_dialog.dart';
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
  final screenName = Get.arguments;

  String _fileInputName = "";
  Timer? _timer;
  Timer? _countdownTimer;

  final imageInput = Rx<String?>(null);
  final currentTheme = 1.obs;
  final numberOfResult = 1.obs;
  final useAsset = false.obs;
  final inQueue = (-1).obs;
  final remainTime = (-1).obs;

  final exteriorAssets = [
    "lib/assets/samples/exterior-sample-1.jpg",
    "lib/assets/samples/exterior-sample-2.jpg"
  ];
  final interiorAssets = [
    "lib/assets/samples/interior-sample-1.jpg",
    "lib/assets/samples/interior-sample-2.jpg"
  ];

  @override
  void onInit() {
    listTheme = screenName == "Interior"
        ? _themeServices.getListInteriors()
        : _themeServices.getListExteriors();
    currentTheme.value = listTheme[0].id;
    super.onInit();
  }

  void _onPickAsset(String assetPath) async {
    useAsset.value = true;
    imageInput.value = assetPath;
    _fileInputName = "sample.jpg";
  }

  void showImageSourcePicker() async {
    var res =
        await showImagePicker<String>(["Camera", "Library", "Use samples"]);
    if (res == null) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    try {
      if (res == "Camera") {
        var image = await picker.pickImage(source: ImageSource.camera);
        useAsset.value = false;
        if (image != null) {
          imageInput.value = image.path;
          _fileInputName = image.name;
        }
        return;
      } else if (res == "Library") {
        useAsset.value = false;
        var image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          imageInput.value = image.path;
          _fileInputName = image.name;
        }
        return;
      } else {
        if (screenName == "Exterior") {
          Get.dialog(SamplesDialog(
            images: exteriorAssets,
            onPress1: () {
              _onPickAsset(exteriorAssets[0]);
            },
            onPress2: () {
              _onPickAsset(exteriorAssets[1]);
            },
          ));
        } else {
          Get.dialog(SamplesDialog(
            images: interiorAssets,
            onPress1: () {
              _onPickAsset(interiorAssets[0]);
            },
            onPress2: () {
              _onPickAsset(interiorAssets[1]);
            },
          ));
        }
      }
    } catch (e) {
      showSnackbarError("$e");
    }
  }

  void startPredict() async {
    _showLoadingDialog();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainTime.value > 0) {
        remainTime.value -= 1;
      }
    });
    try {
      final imageUrl = await _predictServices.uploadImage(
          imageInput.value!, _fileInputName, useAsset.value);
      debugPrint("Image url: $imageUrl");
      final predictMap = await _predictServices.predict(
          imageUrl, currentTheme.value, numberOfResult.value);
      final predictId = predictMap['predictId'];
      debugPrint("Predict id: $predictId");
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
        try {
          final resultUrls = await _predictServices.getResults(predictId);
          debugPrint("Get result: $resultUrls, type ${resultUrls.runtimeType}");
          if (resultUrls == null) {
            return;
          }
          if (resultUrls.runtimeType == List<String>) {
            _cancelTimer();
            Get.back();
            Get.toNamed(Routes.results, arguments: resultUrls);
            timer.cancel();
          } else {
            inQueue.value = resultUrls['inQueue'];
            if (remainTime.value == -1) {
              remainTime.value = resultUrls['initialCountDown'];
            }
          }
        } catch (e) {
          Get.back();
          _cancelTimer();
          debugPrint("Get result error: ${e.toString()}");
          timer.cancel();
          //Get result error
        }
      });
    } catch (e) {
      Get.back();
      _cancelTimer();
      debugPrint("error: $e");
      showSnackbarError(e.toString());
    }
  }

  void _cancelTimer() {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
      _timer = null;
    }
    if (_countdownTimer != null) {
      if (_countdownTimer!.isActive) {
        _countdownTimer!.cancel();
      }
      _countdownTimer = null;
    }
    remainTime.value = -1;
    inQueue.value = -1;
  }

  void _showLoadingDialog() {
    Get.dialog(
        LoadingDialog(
          _cancelTimer,
        ),
        barrierDismissible: false);
  }
}
