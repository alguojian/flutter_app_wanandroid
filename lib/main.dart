import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_wanandroid/event/ChangeThemeEvent.dart';
import 'package:flutter_app_wanandroid/mainpage.dart';
import 'package:flutter_app_wanandroid/utils/eventbus_utils.dart';
import 'package:flutter_app_wanandroid/utils/theme_utils.dart';
import 'package:flutter_app_wanandroid/utils/utils.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  getUserInfo();
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

Future<Null> getUserInfo() async {}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Color themeColor = ThemeUtils.currentColorTheme;

  @override
  void initState() {
    super.initState();
    Utils.getThemeColorIndex().then((index) {
      if (null != index) {
        ThemeUtils.currentColorTheme = ThemeUtils.supportColors[index];
        EventBusUtils.eventBus
            .fire(ChangeThemeEvent(ThemeUtils.currentColorTheme));
      }
    });

    //接受消息更新主题颜色  
    EventBusUtils.eventBus.on<ChangeThemeEvent>().listen((onData) {
      setState(() {
        themeColor = onData.mColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
      backgroundColor: themeColor,
      textPadding: const EdgeInsets.all(4),
      radius: 16.0,
      child: MaterialApp(
        title: "玩安卓",
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: themeColor, brightness: Brightness.light),
        home: MainPage(),
      ),
    );
  }
}
