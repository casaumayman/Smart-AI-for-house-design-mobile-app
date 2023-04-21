import 'dart:async';

import 'package:change_house_colors/constants/localstorage_constants.dart';
import 'package:change_house_colors/modules/home/components/loading_dialog.dart';
import 'package:change_house_colors/routes/routes.dart';
import 'package:change_house_colors/shared/models/theme/theme_model.dart';
import 'package:change_house_colors/shared/services/services.dart';
import 'package:change_house_colors/shared/utils/image_picker_utils.dart';
import 'package:change_house_colors/shared/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EDesignMode { interior, exterior }

class HomeController extends GetxController {
  final _themeServices = Get.find<ThemeService>();
  final _predictServices = Get.find<PredictService>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final RxList<ThemeModel> listTheme = RxList.empty();
  final designMode = EDesignMode.exterior.obs;
  final imageInput = Rx<String?>(null);
  final currentTheme = (-1).obs;
  final numberOfResult = 1.obs;
  final useAsset = false.obs;
  final inQueue = (-1).obs;
  final remainTime = (-1).obs;

  String _fileInputName = "";
  Timer? _timer;
  Timer? _countdownTimer;

  static const exteriorAssets = [
    "lib/assets/samples/exterior-sample-1.jpg",
    "lib/assets/samples/exterior-sample-2.jpg"
  ];
  static const interiorAssets = [
    "lib/assets/samples/interior-sample-1.jpg",
    "lib/assets/samples/interior-sample-2.jpg"
  ];

  @override
  onInit() {
    listTheme.addAll(_themeServices.getListExteriors());
    currentTheme.value = listTheme[0].id;
    super.onInit();
  }

  void openDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  changeLanguage(Locale locale) async {
    if (Get.locale == locale) {
      return;
    }
    Get.updateLocale(locale);
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(localeKey, locale.toLanguageTag());
  }

  changeMode(EDesignMode mode) {
    if (designMode.value == mode) {
      return;
    }
    designMode.value = mode;
    //Reset
    _fileInputName = "";
    imageInput.value = null;
    if (mode == EDesignMode.exterior) {
      listTheme.assignAll(_themeServices.getListExteriors());
    } else {
      listTheme.assignAll(_themeServices.getListInteriors());
    }
    currentTheme.value = listTheme.isNotEmpty ? listTheme[0].id : -1;
  }

  void onPickAsset(String assetPath) async {
    imageInput.value = assetPath;
    _fileInputName = "sample.jpg";
    useAsset.value = true;
  }

  void showImageSourcePicker() async {
    var res = await showImagePicker<String>(["camera".tr, "library".tr]);
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
        useAsset.value = false;
        return;
      } else if (res == "Library") {
        var image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          imageInput.value = image.path;
          _fileInputName = image.name;
        }
        useAsset.value = false;
        return;
      }
    } catch (e) {
      showSnackbarError("$e");
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
            if (remainTime.value <= 0) {
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
}
