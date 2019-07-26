import 'package:dio/dio.dart';
import 'package:flutter_app_wanandroid/bean/user_info_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';

///用户信息工具类，构造单例模式
class UserInfoUtils {
  static final UserInfoUtils singleton = UserInfoUtils._internal();

  factory UserInfoUtils() {
    return singleton;
  }

  UserInfoUtils._internal();

  List<String> cookie;
  String userName;

  ///登录成功后缓存cookies和用户名
  void saveUserInfo(UserInfoBean userInfoBean, Response response) {
    List<String> cookies = response.headers["set-cookie"];
    cookie = cookies;
    userName = userInfoBean.data.username;
    _saveInfo();
  }

  void _saveInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", cookie);
    sp.setString("username", userName);
  }

  ///都是骚操作，打开app读取用户cookie和用户名，缓存到内存中
  Future<Null> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> cookies = sp.getStringList("cookies");
    if (cookies != null) {
      cookie = cookies;
    }

    String username = sp.getString("username");
    if (username != null) {
      userName = username;
    }
  }

  ///退出登录时，清空本地缓存数据
  void clearUserInfo() {
    cookie = null;
    userName = null;
    _clearInfo();
  }

  void _clearInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList("cookies", null);
    sp.setString("username", null);
  }
}
