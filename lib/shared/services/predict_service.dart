import 'dart:async';
import 'dart:io';
import 'package:change_house_colors/constants/network_constants.dart';
import 'package:change_house_colors/shared/models/predict_base_res.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PredictService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = networkHost;
  }

  Future<int?> postPredict(
      String imgName, Uint8List file, String mineType) async {
    debugPrint("postPredict");
    final form = FormData({
      'file': MultipartFile(file, filename: imgName, contentType: mineType)
    });
    final res = await post<PredictBaseResponse<Map<String, dynamic>>>(
        '/predict', form,
        decoder: PredictBaseResponse<Map<String, dynamic>>.fromJson,
        headers: {
          "Content-Type": "multipart/form-data; boundary=${form.boundary}"
        });
    if (res.body?.isError ?? false) {
      throw Exception(res.body?.errorDetail ?? 'Some thing happened');
    }
    // debugPrint("post predict res: ${res.body?.data}");
    return res.body?.data?['predictId'];
  }

  Future<PredictBaseResponse<String?>> getMaskImageUrl(int predictId) async {
    final res = await get<PredictBaseResponse<String?>>(
        '/predict/mask-url/$predictId',
        decoder: PredictBaseResponse<String?>.fromJson);
    return res.body!;
  }

  Future<Uint8List> downloadImage(String url) async {
    HttpClient httpClient = HttpClient();
    final request =
        await httpClient.getUrl(Uri.parse("$networkHost/$maskImageUrl/$url"));
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Error getting image from $url');
    }
    final bytes = await consolidateHttpClientResponseBytes(response);
    return bytes;
  }
}
