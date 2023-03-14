import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:change_house_colors/modules/home/helper.dart';
import 'package:change_house_colors/modules/home/models/process_status.dart';
import 'package:change_house_colors/routes/routes.dart';
import 'package:change_house_colors/shared/models/predict_req.dart';
import 'package:change_house_colors/shared/models/predict_res.dart';
import 'package:change_house_colors/shared/services/services.dart';
import 'package:change_house_colors/shared/utils/image_picker_utils.dart';
import 'package:change_house_colors/shared/utils/snackbar_utils.dart';
import 'package:change_house_colors/shared/utils/timing_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class HomeController extends GetxController {
  final _socketService = Get.find<SocketService>();
  final _historyService = Get.find<HistoryService>();
  final _predictService = Get.find<PredictService>();
  final _themeService = Get.find<ThemeService>();

  final currentInputImage = Rx<Uint8List?>(null);
  final currentOutputImage = Rx<Uint8List?>(null);
  final allowGoToHistory = false.obs;
  final isConnectSocket = false.obs;
  final currentStatus = Rx<EProcessStatus>(EProcessStatus.init);

  RGBArray? _maskRGB;
  RGBArray? _originRGB;
  Uint8List? resizedBytes;
  String mimeType = "png";

  @override
  void onInit() {
    isConnectSocket.bindStream(_socketService.isConnected.stream);
    _historyService.isEmpty.stream.listen((v) {
      allowGoToHistory(!v);
    });
    super.onInit();
  }

  void _resize(XFile xFile) async {
    try {
      currentStatus(EProcessStatus.resizing);
      String? mime = lookupMimeType(xFile.path);
      if (mime == null) {
        throw Exception("Picture isn't valid!");
      }
      mimeType = mime;
      final resizedByte = await resizedBytesIsolate(xFile);
      resizedBytes = resizedByte;
      currentInputImage(resizedByte);
      _sendPredictToServer(resizedByte);
    } on Exception catch (e) {
      currentStatus(EProcessStatus.error);
      showSnackbarError(e.toString());
      debugPrint("Error: $e");
    }
  }

  Future<String> _poollingMaskUrl(int predictId) async {
    Completer<String> completer = Completer<String>();
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      final maskUrl = await _predictService.getMaskImageUrl(predictId);
      debugPrint("polling maskURL: $maskUrl");
      if (maskUrl.isError == true) {
        timer.cancel();
        completer.completeError(Exception(maskUrl.errorDetail));
      }
      if (maskUrl.data != null) {
        timer.cancel();
        completer.complete(maskUrl.data);
      }
    });
    return completer.future;
  }

  void _sendPredictToServer(Uint8List resizedByte) async {
    try {
      currentStatus(EProcessStatus.waitingServer);
      final now = DateTime.now().millisecondsSinceEpoch;
      String ext = mimeType.split('/')[1];
      String fileName = "ori_$now.$ext";
      var predictId =
          await _predictService.postPredict(fileName, resizedByte, mimeType);
      if (predictId == null) {
        throw Exception("Predict ID null");
      }
      final maskUrl = await _poollingMaskUrl(predictId);
      final bytes = await _predictService.downloadImage(maskUrl);
      _processResponse(bytes);
    } on Exception catch (e) {
      currentStatus(EProcessStatus.error);
      debugPrint("Error: $e");
      showSnackbarError(e.toString());
    }
  }

  void _mappingColor() async {
    currentStatus(EProcessStatus.colorMapping);
    TimeMeasure mappingColorMeasure = TimeMeasure("Mapping color!");
    var coloredRGB =
        mappingColor(_originRGB!, _maskRGB!, _themeService.selectedTheme);
    mappingColorMeasure.nextMeasure("mappingColorIsolate");
    var image = await convertRGBToImage(coloredRGB);
    mappingColorMeasure.nextMeasure("convertRGBToImageIsolate");
    var bytes = await image.toByteData(format: ImageByteFormat.png);
    mappingColorMeasure.nextMeasure("toByteData");
    if (bytes == null) {
      throw Exception("bytes == null");
    }
    currentOutputImage(Uint8List.view(bytes.buffer));
    mappingColorMeasure.nextMeasure("Uint8List.view");
    currentStatus(EProcessStatus.done);
  }

  void setTheme(String themeName) async {
    if (themeName == _themeService.selectedTheme.name) {
      return;
    }
    _themeService.setTheme(themeName);
    if (_maskRGB != null && _originRGB != null) {
      _mappingColor();
    }
  }

  void _processResponse(Uint8List bytes) async {
    // var originBytes = await getBytesFromXfileIsolate(currentInputImage.value!);
    var maskRGB = await convertBytesToRGB(bytes);
    var originRGB = await convertBytesToRGB(resizedBytes!);
    if (maskRGB == null || originRGB == null) {
      throw Exception("list_rgb or origin_rgb null");
    }
    _maskRGB = maskRGB;
    _originRGB = originRGB;
    _mappingColor();
  }

  void showImageSourcePicker() async {
    var res = await showImagePicker<String>(["Camera", "Library"]);
    if (res == null) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    if (res == "Camera") {
      var image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _resize(image);
      }
      return;
    }
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _resize(image);
    }
  }

  void gotoHistory() {
    Get.toNamed(Routes.history);
  }
}
