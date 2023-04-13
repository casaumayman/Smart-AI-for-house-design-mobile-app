import 'package:change_house_colors/routes/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  onPressInterior() async {
    // await _prepareSamples("Interior");
    Get.toNamed(Routes.decorate, arguments: "Interior design");
  }

  onPressExterior() async {
    // await _prepareSamples("Exterior");
    Get.toNamed(Routes.decorate, arguments: "Exterior design");
  }
}
