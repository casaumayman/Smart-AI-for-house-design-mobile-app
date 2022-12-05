class PredictRequest {
  PredictRequest({required this.fileName, required this.pictureBase64});

  String fileName;
  String pictureBase64;

  Map<String, dynamic> toJson() =>
      {"file_name": fileName, "picture_base64": pictureBase64};
}
