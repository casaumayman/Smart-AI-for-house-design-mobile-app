import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:change_house_colors/shared/data_transfer_objects/predict/predict_req.dart';
import 'package:change_house_colors/shared/utils/network_utils.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
// import 'package:get/get.dart';

class PredictService extends GetxService {
  Future<String> uploadImage(
      String filePath, String fileName, bool useAsset) async {
    final file = File(filePath);
    final ext = path.extension(fileName).substring(1);
    late final MultipartFile multipartFile;
    if (useAsset) {
      final ByteData imageData = await rootBundle.load(filePath);
      final Uint8List uint8List = imageData.buffer.asUint8List();
      final List<int> imageDataBytes = uint8List.toList();
      multipartFile = MultipartFile.fromBytes(imageDataBytes,
          filename: fileName, contentType: MediaType('image', ext));
    } else {
      multipartFile = await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('image', ext));
    }
    final map = {
      "file": multipartFile,
    };
    final imageUrl =
        await NetworkUtils.uploadFile("/predict/upload-input", map);
    return imageUrl;
  }

  Future<Map> predict(String inputUrl, int themeId, int numOfResult) async {
    final data = PredictReq(inputUrl, numOfResult, themeId);
    final dataMap = await NetworkUtils.post("/predict", data.toJson());
    return dataMap;
  }

  Future<dynamic> getResults(int predictId) async {
    final response = await NetworkUtils.get("/predict/get-results/$predictId");
    if (response == null) {
      return null;
    }
    if (response['images'] != null) {
      return List<String>.from(response['images']);
    }
    if (response['inQueue'] != null) {
      return response;
    }
    return null;
  }
}
