import 'package:flutter/material.dart';
import 'package:flutter_app_wanandroid/utils/constaant.dart';
import 'package:flutter_app_wanandroid/utils/eventbus_utils.dart';

///侧滑页面
class DrawerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DrawerPageState();
}

class DrawerPageState extends State<DrawerPage> {
  bool _isLogin = false;
  String userName = "请先登录";

  @override
  void initState() {
    super.initState();

    EventBusUtils.eventBus.on().listen((onData) {
      if (onData == Constant.LOGIN_SUCCESS_EVENT) {
        _isLogin = true;
        userName = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
