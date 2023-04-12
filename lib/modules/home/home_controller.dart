import 'package:change_house_colors/routes/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // _saveSingleFile(String imageName, Uint8List bytes) async {
  //   if (Platform.isAndroid) {
  //     final imagePath = '/sdcard/Download/$imageName';
  //     final imageFile = File(imagePath);
  //     await imageFile.writeAsBytes(bytes);
  //     debugPrint("Image path: $imagePath");
  //     return;
  //   } else {
  //     final result = await ImageGallerySaver.saveImage(
  //       bytes,
  //     );
  //     if (result['isSuccess']) {
  //       debugPrint('Image saved to Photos!');
  //     } else {
  //       debugPrint('Failed to save image to Photos');
  //     }
  //     return;
  //   }
  // }

  // _writeFiles(List<String> files) async {
  //   for (final String assetImage in files) {
  //     final ByteData bytes = await rootBundle.load(assetImage);
  //     final Uint8List imageData = bytes.buffer.asUint8List();
  //     final String imageName = assetImage.split('/').last;
  //     await _saveSingleFile(imageName, imageData);
  //   }
  // }

  // _prepareSamples(String type) async {
  //   Get.dialog(
  //       AlertDialog(
  //         content: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.max,
  //             children: const [
  //               CircularProgressIndicator(),
  //               SizedBox(width: 20),
  //               Text("Loading..."),
  //             ]),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Get.back();
  //             },
  //             child: const Text("Cancel"),
  //           ),
  //         ],
  //       ),
  //       barrierDismissible: false);
  //   if (Platform.isAndroid) {
  //     String directory = 'sdcard/Download';
  //     await Directory(directory).create(recursive: true);
  //   }
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (type == "Interior") {
  //     final String? interiorFlag = prefs.getString('Interior');
  //     if (interiorFlag == null) {
  //       final List<String> assetImages = [
  //         'lib/assets/samples/interior-sample-1.jpg',
  //         'lib/assets/samples/interior-sample-2.jpg',
  //       ];
  //       await _writeFiles(assetImages);
  //       await prefs.setString("Interior", "OK");
  //     }
  //   } else {
  //     final String? exteriorFlag = prefs.getString('Exterior');
  //     if (exteriorFlag == null) {
  //       final List<String> assetImages = [
  //         'lib/assets/samples/exterior-sample-1.jpg',
  //         'lib/assets/samples/exterior-sample-2.jpg',
  //       ];
  //       await _writeFiles(assetImages);
  //       await prefs.setString("Exterior", "OK");
  //     }
  //   }
  //   Get.back();
  // }

  onPressInterior() async {
    // await _prepareSamples("Interior");
    Get.toNamed(Routes.decorate, arguments: "Interior");
  }

  onPressExterior() async {
    // await _prepareSamples("Exterior");
    Get.toNamed(Routes.decorate, arguments: "Exterior");
  }
}
