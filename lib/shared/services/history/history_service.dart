import 'dart:convert';
import 'dart:io';

import 'package:change_house_colors/constants/localstorage_constants.dart';
import 'package:change_house_colors/shared/services/history/history_model.dart';
import 'package:change_house_colors/shared/utils/snackbar_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService extends GetxService {
  late final SharedPreferences _localStore;
  final _history = RxList<HistoryModel>([]);
  List<HistoryModel> get listData {
    return _history.toList();
  }

  final isEmpty = true.obs;

  @override
  void onInit() async {
    _localStore = await SharedPreferences.getInstance();
    final jsonStr = _localStore.getString(historyKey);
    if (jsonStr != null) {
      final parsedMap = jsonDecode(jsonStr).cast<Map<String, dynamic>>();
      final localData = parsedMap
          .map<HistoryModel>((json) => HistoryModel.fromJson(json))
          .toList();
      _history.addAll(localData);
    }
    _history.listen((data) {
      isEmpty.value = data.isEmpty;
    });
    super.onInit();
  }

  Future<void> addHistory(HistoryModel model) async {
    _history.insert(0, model);
    await _localStore.setString(historyKey, jsonEncode(_history.toList()));
  }

  Future<void> deleteImage(String imageName) async {
    var currentValue = _history.toList();
    //find position of item will remove
    int indexRemoveItem = currentValue.indexWhere((model) {
      final origin = model.originImage;
      if (origin.name == imageName) {
        return true;
      }
      return false;
    });
    if (indexRemoveItem == -1) {
      return;
    }
    final removeModel = currentValue[indexRemoveItem];
    //Remove item
    //Remove files in local folder
    final fileOrigin = File(removeModel.originImage.path);
    final fileProcessed = File(removeModel.processedImage.path);
    try {
      await Future.wait([fileOrigin.delete(), fileProcessed.delete()]);
    } catch (e) {
      showSnackbarError("$e");
    }
    //Update localstore
    currentValue.removeAt(indexRemoveItem);
    await _localStore.setString(historyKey, jsonEncode(currentValue));
    //Update service variable
    _history(currentValue);
    showSnackbarSuccess("Delete success!");
  }
}
