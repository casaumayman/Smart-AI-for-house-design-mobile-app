import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:change_house_colors/shared/services/theme/theme_model.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as image_lib;
import 'package:image_picker/image_picker.dart';

// List<List<List<int>>> equivale numpy array shape (H,W,3)
typedef RGBArray = List<List<List<int>>>;

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

bool _validRGB(int red, int green, int blue) {
  bool validColor(int color) {
    return color >= 0 && color <= 255;
  }

  return validColor(red) && validColor(green) && validColor(blue);
}

int _calculateOverLength(int length) {
  if (length < 0) {
    return 0 - length;
  }
  if (length > 255) {
    return length - 255;
  }
  return 0;
}

double _calculateOverPercent(int over, int moved) {
  if (moved == 0) {
    return 0.0;
  }
  return (over / moved).abs();
}

double _indexTripValue(double a, double b, double c) {
  return max(a, max(b, c));
}

int _normalizeOverValue(int color) {
  if (color < 0) {
    return 0;
  }
  if (color > 255) {
    return 255;
  }
  return color;
}

List<int> _getAverageVector(List<int> sum, int numOfPixel) {
  if (numOfPixel == 0) {
    return [0, 0, 0];
  }
  return [sum[0] ~/ numOfPixel, sum[1] ~/ numOfPixel, sum[2] ~/ numOfPixel];
}

RGBArray mappingColor(RGBArray origin, RGBArray mask, ThemeModel themeModel) {
  List<int> themeRoof = [
    themeModel.roofColor.red,
    themeModel.roofColor.green,
    themeModel.roofColor.blue
  ];
  List<int> themeWall = [
    themeModel.wallColor.red,
    themeModel.wallColor.green,
    themeModel.wallColor.blue
  ];
  List<int> themeDoor = [
    themeModel.doorColor.red,
    themeModel.doorColor.green,
    themeModel.doorColor.blue
  ];
  RGBArray arr = [];
  // 1. Get average value of red, green, blue
  // 1. Get average value of red, green, blue
  // 1.1 Loop all pixel and get num of rgb, sum rgb
  // 1.1.1 Init num of red, green, blue zero: num_of(RGB) = 0
  int noRoof = 0;
  int noWall = 0;
  int noDoor = 0;
  // 1.1.2 Init sum of red, green, blue zero: sum_of(RGB) = 0
  List<int> sumRoof = [0, 0, 0];
  List<int> sumWall = [0, 0, 0];
  List<int> sumDoor = [0, 0, 0];
  //1.1.3 Loop all pixel of (origin, mask) and calculate num of rgb, sum rgb
  for (int i = 0; i < mask.length; i++) {
    final row = mask[i];
    for (int j = 0; j < row.length; j++) {
      final maskPixel = row[j];
      final originPixel = origin[i][j];
      if (listEquals(maskPixel, <int>[0, 0, 0])) {
        //This pixel is background, ignore
        continue;
      }
      if (listEquals(maskPixel, <int>[255, 0, 0])) {
        //This pixel is red, it's roof
        noRoof++;
        sumRoof[0] += originPixel[0];
        sumRoof[1] += originPixel[1];
        sumRoof[2] += originPixel[2];
      } else if (listEquals(maskPixel, <int>[0, 255, 0])) {
        //This pixel is green, it's wall
        noWall++;
        sumWall[0] += originPixel[0];
        sumWall[1] += originPixel[1];
        sumWall[2] += originPixel[2];
      } else {
        //This pixel is blue, it's door
        noDoor++;
        sumDoor[0] += originPixel[0];
        sumDoor[1] += originPixel[1];
        sumDoor[2] += originPixel[2];
      }
    }
  }
  // 1.2 average(RGB) = sum_of(RGB) / num_of(RGB)
  List<int> aveRoof = _getAverageVector(sumRoof, noRoof);
  List<int> aveWall = _getAverageVector(sumWall, noWall);
  List<int> aveDoor = _getAverageVector(sumDoor, noDoor);
  // 2 calculate red, green, blue of vector SD
  List<int> sdRoof = [
    themeRoof[0] - aveRoof[0],
    themeRoof[1] - aveRoof[1],
    themeRoof[2] - aveRoof[2]
  ];
  List<int> sdWall = [
    themeWall[0] - aveWall[0],
    themeWall[1] - aveWall[1],
    themeWall[2] - aveWall[2]
  ];
  List<int> sdDoor = [
    themeDoor[0] - aveDoor[0],
    themeDoor[0] - aveDoor[1],
    themeDoor[0] - aveDoor[2]
  ];
  // 2 Loop all pixel of origin, move color by vector SD
  for (int i = 0; i < origin.length; i++) {
    final row = origin[i];
    List<List<int>> resultRow = [];
    for (int j = 0; j < row.length; j++) {
      final originPixel = row[j];
      final maskPixel = mask[i][j];
      if (listEquals(maskPixel, <int>[0, 0, 0])) {
        //This pixel is background, keep origin color
        resultRow.add(originPixel);
        continue;
      }
      // color0 is origin color
      int red0 = originPixel[0];
      int green0 = originPixel[1];
      int blue0 = originPixel[2];
      // colorM is vector SD color
      int redM = 0;
      int greenM = 0;
      int blueM = 0;
      if (listEquals(maskPixel, <int>[255, 0, 0])) {
        //This pixel is red, it's roof
        redM = sdRoof[0];
        greenM = sdRoof[1];
        blueM = sdRoof[2];
      } else if (listEquals(maskPixel, <int>[0, 255, 0])) {
        //This pixel is green, it's wall
        redM = sdWall[0];
        greenM = sdWall[1];
        blueM = sdWall[2];
      } else {
        //This pixel is blue, it's door
        redM = sdDoor[0];
        greenM = sdDoor[1];
        blueM = sdDoor[2];
      }
      // color1 is color after moved
      int red1 = red0 + redM;
      int green1 = green0 + greenM;
      int blue1 = blue0 + blueM;
      if (_validRGB(red1, green1, blue1)) {
        // Not overflow limit
        resultRow.add([red1, green1, blue1]);
      } else {
        // Overflow limit value
        // Get value over limit
        int redOver = _calculateOverLength(red1);
        int greenOver = _calculateOverLength(green1);
        int blueOver = _calculateOverLength(blue1);
        // Get percent over
        double redOverPercent = _calculateOverPercent(redOver, redM);
        double greenOverPercent = _calculateOverPercent(greenOver, greenM);
        double blueOverPercent = _calculateOverPercent(blueOver, blueM);
        // Find max over percent
        double maxValue =
            _indexTripValue(redOverPercent, greenOverPercent, blueOverPercent);
        double k = 1 - maxValue;
        // Get color2: color moved k percent
        int red2 = _normalizeOverValue(red0 + (redM * k).toInt());
        int green2 = _normalizeOverValue(green0 + (greenM * k).toInt());
        int blue2 = _normalizeOverValue(blue0 + (blueM * k).toInt());
        resultRow.add([red2, green2, blue2]);
      }
    }
    arr.add(resultRow);
  }
  return arr;
}

RGBArray? convertBytesToRGB(Uint8List bytes) {
  final decodedImage = image_lib.decodePng(bytes);
  if (decodedImage == null) {
    debugPrint("decodedImage == null");
    return null;
  }
  final decodedBytes = decodedImage.getBytes(format: image_lib.Format.rgb);
  RGBArray imgArr = [];
  for (int y = 0; y < decodedImage.height; y++) {
    imgArr.add([]);
    for (int x = 0; x < decodedImage.width; x++) {
      int red = decodedBytes[y * decodedImage.width * 3 + x * 3];
      int green = decodedBytes[y * decodedImage.width * 3 + x * 3 + 1];
      int blue = decodedBytes[y * decodedImage.width * 3 + x * 3 + 2];
      imgArr[y].add([red, green, blue]);
    }
  }
  return imgArr;
}

Uint8List convertRGBToBytes(RGBArray array) {
  final width = array[0].length;
  final height = array.length;
  // Reshape (H, W, 3) -> (1)
  List<int> rawPixel = [];
  for (int i = 0; i < array.length; i++) {
    for (int j = 0; j < array[i].length; j++) {
      for (int k = 0; k < 3; k++) {
        rawPixel.add(array[i][j][k]);
      }
    }
  }
  final rgbList = Uint8List(width * height * 4);
  for (var i = 0; i < width * height; i++) {
    final rgbOffset = i * 3;
    final rgbaOffset = i * 4;
    rgbList[rgbaOffset] = rawPixel[rgbOffset]; // red
    rgbList[rgbaOffset + 1] = rawPixel[rgbOffset + 1]; // green
    rgbList[rgbaOffset + 2] = rawPixel[rgbOffset + 2]; // blue
    rgbList[rgbaOffset + 3] = 255; // alpha
  }
  return rgbList;
}

Uint8List _convertRGBToBytes(RGBArray array) {
  final width = array[0].length;
  final height = array.length;
  // Reshape (H, W, 3) -> (1)
  List<int> rawPixel = [];
  for (int i = 0; i < array.length; i++) {
    for (int j = 0; j < array[i].length; j++) {
      for (int k = 0; k < 3; k++) {
        rawPixel.add(array[i][j][k]);
      }
    }
  }
  final rgbList = Uint8List(width * height * 4);
  for (var i = 0; i < width * height; i++) {
    final rgbOffset = i * 3;
    final rgbaOffset = i * 4;
    rgbList[rgbaOffset] = rawPixel[rgbOffset]; // red
    rgbList[rgbaOffset + 1] = rawPixel[rgbOffset + 1]; // green
    rgbList[rgbaOffset + 2] = rawPixel[rgbOffset + 2]; // blue
    rgbList[rgbaOffset + 3] = 255; // alpha
  }
  return rgbList;
}

Future<Image> convertRGBToImage(RGBArray array) async {
  final bytes = _convertRGBToBytes(array);
  final completer = Completer<Image>();
  decodeImageFromPixels(
    bytes,
    array[0].length,
    array.length,
    PixelFormat.rgba8888,
    (result) {
      completer.complete(result);
    },
  );
  return completer.future;
}

Future<RGBArray?> convertBase64ToRGB(String base64) async {
  final bytes = await base64ToBytesIsolate(base64);
  return convertBytesToRGB(bytes);
}

Future<Uint8List> getBytesFromXfileIsolate(XFile file) {
  return compute((xFile) async {
    final bytes = await xFile.readAsBytes();
    final result = bytes.buffer.asUint8List();
    return result;
  }, file);
}
