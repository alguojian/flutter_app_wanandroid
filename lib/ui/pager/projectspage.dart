import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app_wanandroid/base/BasePageWidget.dart';

class ProjectsPage extends BasePageWidget {
  @override
  BasePageWidgetState<BasePageWidget> createPageState() => ProjectsPageState();
}

class ProjectsPageState extends BasePageWidgetState<ProjectsPage> {
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
