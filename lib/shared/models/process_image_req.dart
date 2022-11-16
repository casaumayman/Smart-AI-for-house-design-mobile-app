import 'package:change_house_colors/modules/home/models/theme_style.dart';

class ProcessImageRequest {
  ProcessImageRequest(
      {required this.imageBase64,
      required this.imageName,
      required this.theme});
  String imageBase64;
  ThemeStyle theme;
  String imageName;

  Map<String, dynamic> toJson() =>
      {'image': imageBase64, 'theme': theme.name, 'name': imageName};
}
