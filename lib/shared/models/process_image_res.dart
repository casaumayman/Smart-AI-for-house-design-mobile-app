import 'dart:convert';

class ProcessImageResponse {
  ProcessImageResponse._internal(this.imageBase64, this.imageName);

  String imageBase64;
  String imageName;

  factory ProcessImageResponse.fromJson(String json) {
    final jsonMap = jsonDecode(json);
    return ProcessImageResponse._internal(jsonMap['image'], jsonMap['name']);
  }
}
