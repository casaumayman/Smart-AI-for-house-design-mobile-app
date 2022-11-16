import 'package:change_house_colors/app_controller.dart';
import 'package:change_house_colors/modules/home/models/theme_style.dart';
import 'package:change_house_colors/routes/routes.dart';
import 'package:change_house_colors/shared/services/socket_service.dart';
import 'package:change_house_colors/shared/utils/image_picker_utils.dart';
import 'package:change_house_colors/shared/utils/snackbar_utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class HomeController extends GetxController {
  final _socketService = Get.find<SocketService>();
  final _appController = Get.find<AppController>();

  final currentImage = Rx<XFile?>(null);
  //Init royal theme
  final selectedTheme =
      Rx<ThemeStyle>(ThemeStyle.fromName(ThemeStyle.listHouseTheme[0]));

  void setTheme(ThemeStyle style) {
    selectedTheme(style);
  }

  final isConnectSocket = false.obs;

  @override
  void onInit() {
    isConnectSocket.bindStream(_socketService.isConnected.stream);
    super.onInit();
  }

  void sendInfoToServer() async {
    if (currentImage.value == null) {
      return;
    }
    final image = currentImage.value!;
    String? mimeType = lookupMimeType(image.path);
    if (mimeType == null) {
      showSnackbarError("Picture isn't valid!");
      return;
    }
    _appController.addSentImage(image, selectedTheme.value);
  }

  void showImageSourcePicker() async {
    var res = await showImagePicker<String>(["Camera", "Library"]);
    if (res == null) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    if (res == "Camera") {
      var image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        currentImage(image);
      }
      return;
    }
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      currentImage(image);
    }
  }

  void gotoHistory() {
    //TODO: Check disable button
    Get.toNamed(Routes.history);
  }
}
