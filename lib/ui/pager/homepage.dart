import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app_wanandroid/base/BasePageWidget.dart';
import 'package:flutter_app_wanandroid/bean/article_bean.dart';
import 'package:flutter_app_wanandroid/http/api_service.dart';
import 'package:oktoast/oktoast.dart';

///首页
// ignore: must_be_immutable
class HomePage extends BasePageWidget {
  @override
  BasePageWidgetState<BasePageWidget> createPageState() => HomePageState();
}

class HomePageState extends BasePageWidgetState<HomePage> with AutomaticKeepAliveClientMixin {
  List<ArticleDataData> _lists = List();

  ScrollController _scrollController = ScrollController(); //listView滑动控制器
  bool _showToTopButton = false; //是否显示滑动到顶部
  int _pageNum = 0;

  @override
  void initState() {
    super.initState();
    setAppBarVisable(false);
    showloading();
    _refreshData();
    _scrollController.addListener(() {
      //滑动到底部，加载更多
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {}
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

  void _refreshData() {
    _pageNum = 0;
    getData();
  }

  //获取文章列表数据
  Future<Null> getData() async {
    ApiService().getArticleList((ArticleBean _data) {
      if (_data.errorCode == 0) {
        showContent();
        if (_pageNum == 0) {
          if (_data.data.datas.isEmpty) {
            showEmpty();
          } else {
            setState(() {
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
    }, (errorBack) {
      showError();
    }, _pageNum);
  }

  @override
  AppBar getAppBar() {
    return AppBar(
      title: Text("hah"),
    );
  }

  @override
  Widget getContentWidget(BuildContext buildContext) {
    return Scaffold(
        body: RefreshIndicator(
          child: ListView.separated(
              itemBuilder: _itemBuild,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 0.5,
                  color: Colors.black26,
                );
              },
              itemCount: _lists.length + 2),
          onRefresh: _refreshData,
          displacement: 25,
        ),
        floatingActionButton: !_showToTopButton
            ? null
            : FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
                },
                child: Icon(Icons.arrow_upward),
              ));
  }

  Widget _itemBuild(BuildContext context, int index) {
    if (0 == index) {
      return Container(
        height: 200,
        color: Colors.green,
        child: Center(),
      );
    } else if (index < _lists.length - 1) {
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
                    style: TextStyle(fontSize: 14),
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
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Expanded(
                  child: Text(
                _lists[index - 1].title,
                maxLines: 2,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.left,
              )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                _lists[index - 1].superChapterName,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );
    }
    return null;
  }

  @override
  void onRetryListener() {
    showloading();
    _refreshData();
  }

  @override
  bool get wantKeepAlive => true;
}
