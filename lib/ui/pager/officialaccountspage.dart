import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_wanandroid/base/BasePageWidget.dart';

// ignore: must_be_immutable
class OfficialAccountsPage extends BasePageWidget {
  @override
  BasePageWidgetState<BasePageWidget> createPageState() =>
      OfficialAccountsPageState();
}

class OfficialAccountsPageState
    extends BasePageWidgetState<OfficialAccountsPage> {
  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("da"),
    );
  }

  @override
  Widget getContentWidget(BuildContext buildContext) {
    return null;
  }

  @override
  void onRetryListener() {
  }
}
