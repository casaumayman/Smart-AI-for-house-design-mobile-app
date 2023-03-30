import 'package:change_house_colors/shared/data_transfer_objects/theme/get_list_theme_res.dart';
import 'package:change_house_colors/shared/models/theme/theme_model.dart';
import 'package:change_house_colors/shared/utils/network_utils.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  List<ThemeModel> _interiors = [];
  List<ThemeModel> _exteriors = [];

  List<ThemeModel> getListInteriors() {
    return _interiors;
  }

  List<ThemeModel> getListExteriors() {
    return _exteriors;
  }

  loadListTheme() async {
    final response = await NetworkUtils.get('/theme');
    final GetListThemeRes res = GetListThemeRes.fromJson(response);
    _interiors = res.interior;
    _exteriors = res.exterior;
  }
}
