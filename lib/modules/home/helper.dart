import 'dart:convert';
import 'package:change_house_colors/shared/services/theme/theme_model.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List> base64ToBytesIsolate(String mask) async {
  Uint8List readBytes(String pictureMask) {
    String base64 = pictureMask.split(',')[1];
    final bytes = base64Decode(base64);
    return bytes;
  }

  return compute(readBytes, mask);
}

Future<String> xFileToBase64Isolate(XFile file) async {
  final imageBytes = await file.readAsBytes();
  String base64encoded = await compute(base64Encode, imageBytes);
  return base64encoded;
}

List<int> mappingColor(Image origin, Uint8List mask, ThemeModel themeModel) {
  var matrix = encodePng(origin, level: 0);
  return matrix;
}
