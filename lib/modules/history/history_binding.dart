import 'package:change_house_colors/modules/history/history_controller.dart';
import 'package:get/get.dart';

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HistoryController());
  }
}
