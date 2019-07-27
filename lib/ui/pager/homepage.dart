import 'package:flutter/material.dart';
import 'package:flutter_app_wanandroid/base/BasePageWidget.dart';
import 'package:flutter_app_wanandroid/bean/article_bean.dart';
import 'package:flutter_app_wanandroid/http/api_service.dart';
import 'package:oktoast/oktoast.dart';

///首页
// ignore: must_be_immutable
class HomePage extends BasePageWidget {
  @override
  HomePageState createPageState() => HomePageState();
}

class HomePageState extends BasePageWidgetState<HomePage> with AutomaticKeepAliveClientMixin {
  List<Datas> _lists = List();

  ScrollController _scrollController = ScrollController(); //listView滑动控制器
  bool _showToTopButton = true; //是否显示滑动到顶部
  int _pageNum = 0;

  @override
  void initState() {
    super.initState();
    setAppBarVisable(false);
    toast("haha");
//    showloading();
//    showError();
//    _refreshData();
    _scrollController.addListener(() {
      //滑动到底部，加载更多
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _pageNum++;
//        _getData();
      }
    });

    //当前位置超过屏幕高度
    if (_scrollController.offset < 200 && _showToTopButton) {
      setState(() {
        _showToTopButton = false;
      });
    } else if (_scrollController.offset >= 200 && !_showToTopButton) {
      setState(() {
        _showToTopButton = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _refreshData() async{
    _pageNum = 0;
//    _getData();
  }

  void _getData()async{
    ApiService().getArticleList(_pageNum).then((_data) {
      if (null == _data) {
        showError();
      } else if (_data.errorCode == 0) {
        debugPrint("------------------------------111");
        showloading();
//        showContent();
        if (_pageNum == 0) {
          if (_data.data.datas.isEmpty) {
            showEmpty();
          } else {
            setState(() {
              debugPrint("------------------------------${_data.data.datas.length}");
              _lists.clear();
              _lists.addAll(_data.data.datas);
            });
          }
        } else {
          _lists.addAll(_data.data.datas);
        }
      } else {
        showToast(_data.errorMsg);
        showError();
      }
    });
  }

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("hah"),
    );
  }

//  @override
//  Widget getContentWidget(BuildContext buildContext) {
//    return Scaffold(
//        body: RefreshIndicator(
//          child:
//              Column(
//                children: <Widget>[
//                  Text("asdasdasd")
//                ],
//              )
////          ListView.separated(
////              itemBuilder: _itemBuild,
////              controller: _scrollController,
////              physics: AlwaysScrollableScrollPhysics(),
////              separatorBuilder: (BuildContext context, int index) {
////                return Container(
////                  height: 0.5,
////                  color: Colors.black26,
////                );
////              },
////              itemCount: _lists.length + 1),
////          onRefresh: _refreshData,
////          displacement: 15,
//        ),
//        floatingActionButton: !_showToTopButton
//            ? null
//            : FloatingActionButton(
//                onPressed: () {
//                  _scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
//                },
//                child: Icon(Icons.arrow_upward),
//              ));
//  }

  Widget _itemBuild(BuildContext context, int index) {
    if (index==0) {
      return Container(
        height: 200,
        color: Colors.green,
        child: Text("dadasds"),
      );
    } else {
      return InkWell(
        onTap: () {
          showToast("点击事件暂无完成");
        },
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: <Widget>[
                  Text(
                    _lists[index - 1].author,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                      child: Text(
                    _lists[index - 1].niceDate,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.right,
                  ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    _lists[index - 1].title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(
                    _lists[index - 1].superChapterName,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void onRetryListener() {
//    showloading();
//    _refreshData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget getContentWidget(BuildContext buildContext) {
    return Container(
      width: 200,
      height: 300,
      color: Colors.green,
      child: Text("asdasdadasd"),
    );
  }
}
