import 'dart:convert';

import 'package:change_house_colors/constants/network_constants.dart';
import 'package:change_house_colors/shared/models/predict_req.dart';
import 'package:change_house_colors/shared/models/predict_res.dart';
import 'package:change_house_colors/shared/utils/timing_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PredictService extends GetxService {
  var baseUrl = networkHost;
  var client = http.Client();

  Future<PredictResponse> getPredictMask(PredictRequest request) {
    Future<PredictResponse> parseResponse(PredictRequest request) async {
      var url = Uri.parse("$baseUrl/predict");
      TimeMeasure timeMeasure = TimeMeasure("Prepair for request!");
      var jsonMap = request.toJson();
      timeMeasure.nextMeasure("Convert to json");
      var jsonEncoder = jsonEncode(jsonMap);
      timeMeasure.nextMeasure("Encode json, send request");
      var res = await client.post(url,
          headers: {"Content-Type": "application/json"}, body: jsonEncoder);
      timeMeasure.nextMeasure("Get response");
      if (res.statusCode == 200) {
        var jsonDecoded = jsonDecode(res.body);
        timeMeasure.nextMeasure("json decode");
        var resObject = PredictResponse.fromJson(jsonDecoded);
        timeMeasure.nextMeasure("Decode from Json");
        return resObject;
      } else {
        throw Exception("Bad request!");
      }
    }

    return compute(parseResponse, request);
  }
}
