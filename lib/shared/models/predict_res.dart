class PredictResponse {
  PredictResponse._internal(
      {required this.fileName, required this.pictureMask});

  String fileName;
  String pictureMask;

  factory PredictResponse.fromJson(Map jsonMap) {
    // final jsonMap = jsonDecode(json);
    return PredictResponse._internal(
        fileName: jsonMap['file_name'], pictureMask: jsonMap['picture_mask']);
  }

  @override
  String toString() {
    return "FileName: $fileName, Mask: ${pictureMask.length}";
  }
}
