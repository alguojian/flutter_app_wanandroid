import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_wanandroid/utils/theme_utils.dart';
import 'package:oktoast/oktoast.dart';
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
  MyAppState createState() =>MyAppState();
}

class MyAppState extends State<MyApp> {
  Color themeColor = ThemeUtils.currentColorTheme;

@override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: themeColor,
      radius: 14.0,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: themeColor, brightness: Brightness.light),
        home: Container(),
      ),
    );
  }
}
