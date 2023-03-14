import 'dart:convert';
import 'dart:io';
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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';

class AppController extends GetxController {
  final _socketService = Get.find<SocketService>();
  final _historyService = Get.find<HistoryService>();

  final List<LocalImage> _waitProcessingPool = [];

  @override
  void onInit() {
    // _socketService.connect();
    // _socketService.onReceive((data) {
    //   final responseModel = ProcessImageResponse.fromJson(data);
    //   debugPrint("Received data: ${responseModel.imageName}");
    //   _handleProcessedImage(responseModel);
    // });
    // _saveSampleImages();
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

  Future<String> _getPicturesDirectory() async {
    // final directory = await getExternalStorageDirectory();
    // return '${directory!.path}/Download/images';
    return "/sdcard/Download/images";
  }

  Future<bool> _requestPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> _imageExists(String imageName) async {
    final directory = await _getPicturesDirectory();
    debugPrint("Document dir: $directory");
    final file = File('$directory/$imageName');
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }
    return file.exists();
  }

  Future<List<ByteData>> _loadBundleImage(List<String> imageNames) async {
    final listFuture = imageNames.map((name) {
      return rootBundle.load('lib/assets/$name');
    }).toList();
    return Future.wait(listFuture);
  }

  List<Uint8List> _convertByteToUint8List(List<ByteData> bytes) {
    return bytes.map((byte) => byte.buffer.asUint8List()).toList();
  }

  Future _saveFiles(List<Uint8List> uint8List) async {
    String dir = await _getPicturesDirectory();
    for (var i = 1; i <= 5; i++) {
      var name = "1_${i}_org.png";
      File file = File('$dir/$name');
      var byteData = uint8List[i - 1];
      await file.writeAsBytes(byteData);
    }
  }

  void _saveSampleImages() async {
    final permission = await _requestPermission();
    if (!permission) {
      debugPrint("Not have permission");
      return;
    }
    var imageNames = <String>[];
    for (var i = 1; i <= 5; i++) {
      imageNames.add("1_${i}_org.png");
    }
    final listFuture = imageNames.map((name) {
      return _imageExists(name);
    }).toList();
    final checkResult = await Future.wait(listFuture);
    if (checkResult.every((element) => element)) {
      debugPrint("Images has exits");
      return;
    }
    final listBytes = await _loadBundleImage(imageNames);
    final listUint8 = _convertByteToUint8List(listBytes);
    _saveFiles(listUint8);
  }
}
