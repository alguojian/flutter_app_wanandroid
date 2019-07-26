///用户信息工具类，构造单例模式
class UserInfoUtils {
  static final UserInfoUtils singleton = UserInfoUtils._internal();

  factory UserInfoUtils() {
    return singleton;
  }
  UserInfoUtils._internal();

  List<String> cookie;
  String userName;

  void saveUserInfo() {}
}
