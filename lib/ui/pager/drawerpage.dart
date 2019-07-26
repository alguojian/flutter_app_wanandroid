import 'package:flutter/material.dart';
import 'package:flutter_app_wanandroid/event/ChangeThemeEvent.dart';
import 'package:flutter_app_wanandroid/utils/constaant.dart';
import 'package:flutter_app_wanandroid/utils/eventbus_utils.dart';
import 'package:flutter_app_wanandroid/utils/theme_utils.dart';
import 'package:flutter_app_wanandroid/utils/userinfoutils.dart';
import 'package:flutter_app_wanandroid/utils/utils.dart';
import 'package:share/share.dart';

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
        setState(() {
          _isLogin = true;
          userName = UserInfoUtils.singleton.userName;
        });
      }
    });

    if (UserInfoUtils.singleton.userName != null) {
      _isLogin = true;
      userName = UserInfoUtils.singleton.userName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: InkWell(
                child: Text(
                  userName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                onTap: () {},
              ),
              accountEmail: Text('jzhszy@foxmail.com'),
              currentAccountPicture: InkWell(
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/avatar.png"),
                ),
                onTap: () {},
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(backgroundImage: AssetImage("images/avatar.png"),),
              ],

              onDetailsPressed: (){},
            ),
            ListTile(
              title: Text(
                "我的收藏",
                textAlign: TextAlign.left,
              ),
              leading: Icon(
                Icons.collections,
                size: 22,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "常用网站",
                textAlign: TextAlign.left,
              ),
              leading: Icon(
                Icons.web,
                size: 22,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "修改主题",
                textAlign: TextAlign.left,
              ),
              leading: Icon(
                Icons.settings,
                size: 22,
              ),
              onTap: () {
                _changeThemeDialog(context);
              },
            ),
            ListTile(
              title: Text(
                "分享",
                textAlign: TextAlign.left,
              ),
              leading: Icon(
                Icons.share,
                size: 22,
              ),
              onTap: () {
                Share.share("给你推荐一个app，下载地址：");
              },
            ),
            ListTile(
              title: Text(
                "看妹子",
                textAlign: TextAlign.left,
              ),
              leading: Icon(
                Icons.directions_bike,
                size: 22,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "about me",
                textAlign: TextAlign.left,
              ),
              leading: Icon(
                Icons.info,
                size: 22,
              ),
              onTap: () {},
            ),
            _logoutWidget(),
          ],
        ),
      ),
    );
  }

  Widget _logoutWidget() {
    if (UserInfoUtils.singleton.userName == null) {
      return SizedBox(
        height: 0,
      );
    } else {
      return ListTile(
        title: Text(
          "登录",
          textAlign: TextAlign.left,
        ),
        leading: Icon(
          Icons.power_settings_new,
          size: 22,
        ),
        onTap: () {
          UserInfoUtils.singleton.clearUserInfo();
          setState(() {
            _isLogin = false;
            userName = "请登录";
          });
        },
      );
    }
  }

  void _changeThemeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("修改主题颜色"),
            children: ThemeUtils.supportColors.map((Color color) {
              return SimpleDialogOption(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  height: 35,
                  color: color,
                ),
                onPressed: () {
                  ThemeUtils.currentColorTheme = color;
                  Utils.setThemeColorIndex(ThemeUtils.supportColors.indexOf(color));
                  EventBusUtils.eventBus.fire(ChangeThemeEvent(color));
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          );
        });
  }
}
