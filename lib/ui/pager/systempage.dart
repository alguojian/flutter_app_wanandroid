import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app_wanandroid/base/BasePageWidget.dart';

// ignore: must_be_immutable
class SystemPage extends BasePageWidget {
  @override
  BasePageWidgetState<BasePageWidget> createPageState() => SystemPageState();
}

class SystemPageState extends BasePageWidgetState<SystemPage> {
  @override
  AppBar getAppBar() {
    return null;
  }

  @override
  Widget getContentWidget(BuildContext buildContext) {
    return null;
  }

  @override
  void onRetryListener() {
  }
}
