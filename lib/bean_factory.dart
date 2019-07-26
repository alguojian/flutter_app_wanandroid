import 'package:flutter_app_wanandroid/bean/user_info_bean.dart';
import 'package:flutter_app_wanandroid/bean/article_bean.dart';

class BeanFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "UserInfoBean") {
      return UserInfoBean.fromJson(json) as T;
    } else if (T.toString() == "ArticleBean") {
      return ArticleBean.fromJson(json) as T;
    } else {
      return null;
    }
  }
}