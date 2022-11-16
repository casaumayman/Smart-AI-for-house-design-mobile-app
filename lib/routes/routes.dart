import 'package:change_house_colors/modules/history/history_binding.dart';
import 'package:change_house_colors/modules/history/history_screen.dart';
import 'package:change_house_colors/modules/home/home_binding.dart';
import 'package:change_house_colors/modules/home/home_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/';
  static const history = '/history';

  static List<GetPage> pages = [
    GetPage(name: home, page: () => const HomeScreen(), binding: HomeBinding()),
    GetPage(
        name: history,
        page: () => const HistoryScreen(),
        binding: HistoryBinding()),
  ];
}
