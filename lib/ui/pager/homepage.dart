import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app_wanandroid/base/BasePageWidget.dart';

class HomePage extends BasePageWidget {
  @override
  BasePageWidgetState<BasePageWidget> createPageState() => HomePageState();
}

class HomePageState extends BasePageWidgetState<HomePage> {
  @override
  AppBar getAppBar() {
    // TODO: implement getAppBar
    return null;
  }

  @override
  Widget getContentWidget(BuildContext buildContext) {
    // TODO: implement getContentWidget
    return null;
  }

  @override
  void onRetryListener() {
    // TODO: implement onRetryListener
  }
}
