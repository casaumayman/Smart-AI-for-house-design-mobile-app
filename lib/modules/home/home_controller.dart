import 'package:change_house_colors/modules/home/helper.dart';
import 'package:change_house_colors/modules/home/models/process_status.dart';
import 'package:change_house_colors/routes/routes.dart';
import 'package:change_house_colors/shared/models/predict_req.dart';
import 'package:change_house_colors/shared/models/predict_res.dart';
import 'package:change_house_colors/shared/services/services.dart';
import 'package:change_house_colors/shared/utils/image_picker_utils.dart';
import 'package:change_house_colors/shared/utils/snackbar_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class HomeController extends GetxController {
  final _socketService = Get.find<SocketService>();
  final _historyService = Get.find<HistoryService>();
  final _predictService = Get.find<PredictService>();
  final _themeService = Get.find<ThemeService>();

  final currentInputImage = Rx<XFile?>(null);
  final currentOutputImage = Rx<Uint8List?>(null);
  final allowGoToHistory = false.obs;
  final isConnectSocket = false.obs;
  final currentStatus = Rx<EProcessStatus>(EProcessStatus.init);

  void _setCurrentImage(XFile file) {
    currentInputImage(file);
    currentStatus(EProcessStatus.waitingServer);
    _sendPredictToServer(file);
  }

  @override
  void onInit() {
    isConnectSocket.bindStream(_socketService.isConnected.stream);
    _historyService.isEmpty.stream.listen((v) {
      allowGoToHistory(!v);
    });
    super.onInit();
  }

  void _processResponse(PredictResponse predict) async {
    final bytes = await base64ToBytesIsolate(predict.pictureMask);
    //TODO: Continue
    var colored =
        await mappingColor("origin", bytes, _themeService.selectedTheme);
    currentOutputImage(bytes);
    currentStatus(EProcessStatus.done);
  }

  void _sendPredictToServer(XFile file) async {
    try {
      String? mimeType = lookupMimeType(file.path);
      if (mimeType == null) {
        showSnackbarError("Picture isn't valid!");
        return;
      }
      String ext = mimeType.split('/')[1];
      String base64encoded = await xFileToBase64Isolate(file);
      String base64 = "data:$mimeType;base64,$base64encoded";
      final now = DateTime.now().millisecondsSinceEpoch;
      String fileName = "ori_$now.$ext";
      final requestModel =
          PredictRequest(pictureBase64: base64, fileName: fileName);
      var response = await _predictService.getPredictMask(requestModel);
      currentStatus(EProcessStatus.colorMapping);
      _processResponse(response);
    } catch (e) {
      currentStatus(EProcessStatus.error);
      debugPrint("Error: $e");
    }
  }

  // void sendInfoToServer() async {
  //   if (currentImage.value == null) {
  //     return;
  //   }
  //   final image = currentImage.value!;
  //   String? mimeType = lookupMimeType(image.path);
  //   if (mimeType == null) {
  //     showSnackbarError("Picture isn't valid!");
  //     return;
  //   }
  //   _appController.addSentImage(image, selectedTheme.value);
  // }

  void showImageSourcePicker() async {
    var res = await showImagePicker<String>(["Camera", "Library"]);
    if (res == null) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    if (res == "Camera") {
      var image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _setCurrentImage(image);
      }
      return;
    }
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _setCurrentImage(image);
    }
  }

  void gotoHistory() {
    Get.toNamed(Routes.history);
  }
}
