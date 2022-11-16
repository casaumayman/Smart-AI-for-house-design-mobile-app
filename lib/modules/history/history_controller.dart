import 'package:get/get.dart';

class HistoryController extends GetxController {
  final total = 10;
  final currentIndex = 0.obs;

  void onChangeIndex(int index) {
    currentIndex.value = index;
  }

  void onDeleteItem() async {
    //TODO: Handle delete image
  }
}
