import 'package:dio/dio.dart';
import 'package:flutter_app_wanandroid/bean/article_bean.dart';
import 'package:flutter_app_wanandroid/bean_factory.dart';
import 'package:flutter_app_wanandroid/http/api.dart';
import 'package:flutter_app_wanandroid/http/dio_manager.dart';
import 'package:flutter_app_wanandroid/utils/userinfoutils.dart';

class ApiService {
  ///首页文章列表
  void getArticleList(Function callback, Function errorBack, int page) async {
    Dio dio = await DioManager.singleton.dio;
    dio.get(Api.HOME_ARTICLE_LIST + "$page/json", options: _getOptions()).then((onValue) {
      print("-----------"+onValue.data);
      callback(BeanFactory.generateOBJ<ArticleBean>(onValue.data));
    }).catchError((onError) {
      errorBack(onError);
      print("------------"+onError.toString());
    });
  }

  Options _getOptions() {
    Map<String, String> map = Map();
    List<String> list = UserInfoUtils.singleton.cookie;
    map["cookie"] = list.toString();
    return Options(headers: map);
  }
}
