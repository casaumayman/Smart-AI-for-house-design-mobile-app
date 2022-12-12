import 'package:change_house_colors/app_controller.dart';
import 'package:change_house_colors/shared/services/services.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HistoryService());
    Get.put(SocketService());
    Get.put(PredictService());
    Get.put(ThemeService());
    Get.put(AppController());
  }
}
