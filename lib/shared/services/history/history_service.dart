import 'dart:convert';

import 'package:change_house_colors/constants/localstorage_constants.dart';
import 'package:change_house_colors/shared/services/history/history_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService extends GetxService {
  late final SharedPreferences localStore;
  final _history = RxList<HistoryModel>([]);

  @override
  void onInit() async {
    localStore = await SharedPreferences.getInstance();
    final jsonStr = localStore.getString(historyKey);
    if (jsonStr != null) {
      final parsedMap = jsonDecode(jsonStr).cast<Map<String, dynamic>>();
      final localData = parsedMap
          .map<HistoryModel>((json) => HistoryModel.fromJson(json))
          .toList();
      _history.addAll(localData);
    }
    super.onInit();
  }

  Future<void> addHistory(HistoryModel model) async {
    _history.insert(0, model);
    await localStore.setString(historyKey, jsonEncode(_history.toList()));
  }

  HistoryModel getByIndex(int index) {
    if (index < 0 || index >= _history.length) {
      throw Exception("Out of index!");
    }
    return _history[index];
  }
}
