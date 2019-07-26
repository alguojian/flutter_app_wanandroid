import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static final String THEME_COLOR_INDEX = "THEME_COLOR_INDEX";

  ///保存本地存储的主题色索引
  static setThemeColorIndex(int index) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(THEME_COLOR_INDEX, index);
  }

  ///获得本地存储的主题色索引
  static Future<int> getThemeColorIndex() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(THEME_COLOR_INDEX);
  }
}
