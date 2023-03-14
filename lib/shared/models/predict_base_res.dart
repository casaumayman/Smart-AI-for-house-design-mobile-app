class PredictBaseResponse<T> {
  PredictBaseResponse._internal(
      {required this.isError, this.data, this.errorDetail});

  bool isError;
  T? data;
  String? errorDetail;

  factory PredictBaseResponse.fromJson(dynamic jsonMap) {
    // final jsonMap = jsonDecode(json);
    if (jsonMap is String) {
      return PredictBaseResponse._internal(
          isError: true, data: null, errorDetail: jsonMap);
    }
    return PredictBaseResponse._internal(
        isError: jsonMap['isError'],
        data: jsonMap['data'],
        errorDetail: jsonMap['errorDetail']);
  }

  @override
  String toString() {
    return "IsError: $isError, errorDetail: $errorDetail, data: $data";
  }
}
