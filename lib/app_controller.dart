import 'dart:convert';
import 'package:change_house_colors/modules/home/models/theme_style.dart';
import 'package:change_house_colors/shared/models/local_image.dart';
import 'package:change_house_colors/shared/models/process_image_req.dart';
import 'package:change_house_colors/shared/models/process_image_res.dart';
import 'package:change_house_colors/shared/services/history/history_model.dart';
import 'package:change_house_colors/shared/services/history/history_service.dart';
import 'package:change_house_colors/shared/services/socket_service.dart';
import 'package:change_house_colors/shared/utils/local_image_utils.dart';
import 'package:change_house_colors/shared/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class AppController extends GetxController {
  final _socketService = Get.find<SocketService>();
  final _historyService = Get.find<HistoryService>();

  final List<LocalImage> _waitProcessingPool = [];

  @override
  void onInit() {
    // _socketService.connect();
    _socketService.onReceive((data) {
      final responseModel = ProcessImageResponse.fromJson(data);
      debugPrint("Received data: ${responseModel.imageName}");
      _handleProcessedImage(responseModel);
    });
    super.onInit();
  }

  void addSentImage(XFile image, ThemeStyle themeStyle) async {
    String? mimeType = lookupMimeType(image.path);
    if (mimeType == null) {
      showSnackbarError("Picture isn't valid!");
      return;
    }
    String ext = mimeType.split('/')[1];
    final imageBytes = await image.readAsBytes();
    String base64 = "data:$mimeType;base64,${base64Encode(imageBytes)}";
    final now = DateTime.now().millisecondsSinceEpoch;
    final themeId = themeStyle.code;
    String fileName = "ori_${now}_$themeId.$ext";
    final requestModel = ProcessImageRequest(
        imageBase64: base64, imageName: fileName, theme: themeStyle);
    var isSuccess = _socketService.requestProcess(requestModel);
    if (!isSuccess) {
      return;
    }
    showSnackbarSuccess("Picture has been sent!");
    final path = await saveLocalImage(imageBytes, fileName, true);
    LocalImage localImage =
        LocalImage(path: path, theme: themeStyle, name: fileName);
    _waitProcessingPool.add(localImage);
  }

  void _handleProcessedImage(ProcessImageResponse processedImage) async {
    //Find image from pool
    final imageFromPool = _waitProcessingPool
        .firstWhereOrNull((img) => img.name == processedImage.imageName);
    if (imageFromPool == null) {
      return;
    }
    //Save processed image
    String base64 = processedImage.imageBase64.split(',')[1];
    final bytes = base64Decode(base64);
    String fileName = processedImage.imageName.replaceRange(0, 3, 'mod');
    final path = await saveLocalImage(bytes, fileName, false);
    LocalImage localProcessedImage =
        LocalImage(path: path, theme: imageFromPool.theme, name: fileName);
    final history = HistoryModel(
        originImage: imageFromPool, processedImage: localProcessedImage);
    await _historyService.addHistory(history);
    showSnackbarInfo("Recieved new picture!");
  }
}
