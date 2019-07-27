import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wanandroid/bean/article_bean.dart';
import 'package:flutter_app_wanandroid/http/api.dart';
import 'package:flutter_app_wanandroid/http/dio_manager.dart';
import 'package:flutter_app_wanandroid/utils/userinfoutils.dart';


class ApiService {
  ///首页文章列表
  Future<ArticleBean> getArticleList(int page) async {
    Dio dio = DioManager.singleton.dio;
    try{
      Response response=await dio.get(Api.HOME_ARTICLE_LIST + "$page/json",options: _getOptions());
      debugPrint("-----------" + response.data.toString());
      return ArticleBean.fromJson(response.data);
    }on DioError catch(e){
      debugPrint("-----------" + e.toString());
      e.type=DioErrorType.CANCEL;
    }
    return null;
  }

  Options _getOptions() {
    Map<String, String> map = Map();
    List<String> list = UserInfoUtils.singleton.cookie;
    map["cookie"] = list.toString();
    return Options(headers: map);
  }
}
