import 'package:change_house_colors/modules/decorate/decorate.dart';
import 'package:change_house_colors/modules/home/home.dart';
import 'package:change_house_colors/modules/result/result_screen.dart';
import 'package:change_house_colors/modules/splash/splash.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/home';
  static const decorate = '/decorate';
  static const results = '/results';

  static List<GetPage> pages = [
    GetPage(
        name: '/',
        page: () => const SplashScreen(),
        binding: BindingsBuilder(() {
          Get.put(SplashController());
        })),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
        name: decorate,
        page: () => const DecorateScreen(),
        binding: DecorateBinding()),
    GetPage(name: results, page: () => const ResultScreen()),
  ];
}
