import 'package:change_house_colors/services/socket_service.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SocketService());
  }
}
