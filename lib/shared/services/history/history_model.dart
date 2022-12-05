import 'package:change_house_colors/shared/models/local_image.dart';

class HistoryModel {
  HistoryModel({required this.originImage, required this.processedImage});

  LocalImage originImage;
  LocalImage processedImage;

  Map<String, dynamic> toJson() =>
      {"originImage": originImage, "processedImage": processedImage};

  factory HistoryModel.fromJson(Map<String, dynamic> jsonMap) {
    return HistoryModel(
        originImage: LocalImage.fromJson(jsonMap["originImage"]),
        processedImage: LocalImage.fromJson(jsonMap["processedImage"]));
  }
}
