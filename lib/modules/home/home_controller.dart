import 'package:change_house_colors/modules/home/models/theme_style.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentImageUrl = Rx<String?>(null);
  //Init royal theme
  final selectedTheme =
      Rx<ThemeStyle>(ThemeStyle.fromName(ThemeStyle.listHouseTheme[0]));
}
