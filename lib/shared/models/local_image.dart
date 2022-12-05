import 'package:change_house_colors/modules/home/models/theme_style.dart';

class LocalImage {
  LocalImage({required this.path, required this.theme, required this.name});

  String path;
  String name;
  ThemeStyle theme;

  Map<String, dynamic> toJson() =>
      {"path": path, "name": name, "theme": theme.name};

  factory LocalImage.fromJson(Map<String, dynamic> jsonMap) {
    final theme = ThemeStyle.fromName(jsonMap["theme"]);
    return LocalImage(
        path: jsonMap["path"], theme: theme, name: jsonMap["name"]);
  }
}
