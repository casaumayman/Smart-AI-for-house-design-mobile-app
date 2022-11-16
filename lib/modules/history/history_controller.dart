import 'package:change_house_colors/shared/services/history/history_model.dart';
import 'package:change_house_colors/shared/services/history/history_service.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final _historyService = Get.find<HistoryService>();
  late List<HistoryModel> data;
  int currentIndex = 0;

  @override
  void onInit() {
    data = _historyService.listData;
    super.onInit();
  }

  void onChangeIndex(int index) {
    currentIndex = index;
    update();
  }

  void onDeleteItem() async {
    Get.defaultDialog(title: "Are you sure?");
    //TODO: delete history
    // final model = data[currentIndex];
  }
}
