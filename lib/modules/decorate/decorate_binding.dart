import 'package:change_house_colors/modules/decorate/decorate_controller.dart';
import 'package:get/get.dart';

class DecorateBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DecorateController());
  }
}
