import 'dart:convert';

import 'package:change_house_colors/constants/network_constants.dart';
import 'package:change_house_colors/shared/models/predict_req.dart';
import 'package:change_house_colors/shared/models/predict_res.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PredictService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = networkHost;
  }

  Future<PredictResponse> getPredictMask(PredictRequest request) {
    Future<PredictResponse> parseResponse(PredictRequest request) async {
      var res = await post("predict", request.toJson());
      var jsonDecoded = jsonDecode(res.bodyString!);
      return PredictResponse.fromJson(jsonDecoded);
    }

    return compute(parseResponse, request);
  }
}
