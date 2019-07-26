import 'package:flutter/material.dart';
import 'package:flutter_app_wanandroid/ui/pager/homepage.dart';
import 'package:flutter_app_wanandroid/ui/pager/navigationpage.dart';
import 'package:flutter_app_wanandroid/ui/pager/officialaccountspage.dart';
import 'package:flutter_app_wanandroid/ui/pager/projectspage.dart';
import 'package:flutter_app_wanandroid/ui/pager/systempage.dart';
import 'package:oktoast/oktoast.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedIndex = 0; //默认选中项第一个
  final appBarTitle = [
    "玩android",
    "android体系",
    "公众号",
    "功能导航",
    "项目介绍"
  ]; //appbar文案
  double elevation = 10;

  var pages = <Widget>[
    HomePage(),
    SystemPage(),
    OfficialAccountsPage(),
    NavigationPage(),
    ProjectsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //拦截返回键
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle[_selectedIndex]),
          centerTitle: true,
          elevation: elevation,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showToast("搜索暂未完成");
              },
            )
          ],
        ),
        body: IndexedStack(
          children: pages,
          index: _selectedIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), title: Text("体系")),
            BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text("公众号")),
            BottomNavigationBarItem(
                icon: Icon(Icons.navigation), title: Text("导航")),
            BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("项目")),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  ///处理底部导航点击逻辑
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2 || index == 4) {
        elevation = 0;
      } else {
        elevation = 10;
      }
    });
  }

  Future<bool> _onWillPop() {
    showToast("再按一次我就退出了😯");
  }
}
